$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$targetConfig = Join-Path $env:LOCALAPPDATA "nvim"
$backupConfig = Join-Path $env:LOCALAPPDATA "nvim.backup"

function Ensure-Command {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$WingetId = ""
    )

    if (Get-Command $Name -ErrorAction SilentlyContinue) {
        return
    }

    if (-not $WingetId) {
        throw "Missing required command '$Name' and no winget ID was provided."
    }

    Write-Host "Installing $Name via winget..."
    & winget install -e --id $WingetId --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install $Name via winget."
    }
}

Write-Host "Configuring Neovim..."
Ensure-Command -Name "nvim" -WingetId "Neovim.Neovim"
Ensure-Command -Name "git" -WingetId "Git.Git"
Ensure-Command -Name "npm" -WingetId "OpenJS.NodeJS.LTS"
Ensure-Command -Name "rg" -WingetId "BurntSushi.ripgrep.MSVC"
Ensure-Command -Name "fd" -WingetId "sharkdp.fd"

if (Test-Path $targetConfig) {
    if (Test-Path $backupConfig) {
        Remove-Item $backupConfig -Recurse -Force
    }
    Rename-Item $targetConfig $backupConfig
    Write-Host "Backed up existing config to $backupConfig"
}

New-Item -ItemType Directory -Path $targetConfig -Force | Out-Null
Copy-Item -Path (Join-Path $repoRoot "*") -Destination $targetConfig -Recurse -Force

$packerDir = Join-Path $targetConfig "pack\packer\start\packer.nvim"
if (-not (Test-Path $packerDir)) {
    Write-Host "Installing Packer..."
    $null = New-Item -ItemType Directory -Path (Split-Path $packerDir) -Force
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $packerDir
}

Write-Host "Installing plugins..."
& nvim --headless -u "$targetConfig\init.lua" +"autocmd User PackerComplete quitall" +PackerSync
if ($LASTEXITCODE -ne 0) {
    throw "Plugin installation failed."
}

Write-Host "Done! Your Neovim config is installed at $targetConfig"
Write-Host "Run 'nvim' to get started."
