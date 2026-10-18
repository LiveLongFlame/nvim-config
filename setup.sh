#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

ensure_command() {
  local cmd="$1"
  local install_cmd="$2"

  if command -v "$cmd" >/dev/null 2>&1; then
    return 0
  fi

  echo "Installing $cmd..."
  if [[ -n "$install_cmd" ]]; then
    eval "$install_cmd"
  else
    echo "Missing required command: $cmd" >&2
    exit 1
  fi
}

ensure_command nvim "sudo apt-get update && sudo apt-get install -y neovim || brew install neovim || echo 'Install neovim manually'"
ensure_command git "sudo apt-get install -y git || brew install git || echo 'Install git manually'"
ensure_command npm "sudo apt-get install -y npm || brew install node || echo 'Install npm manually'"
ensure_command rg "sudo apt-get install -y ripgrep || brew install ripgrep || echo 'Install ripgrep manually'"
ensure_command fd "sudo apt-get install -y fd-find || brew install fd || echo 'Install fd manually'"

mkdir -p "$TARGET_CONFIG"
if [[ -d "$TARGET_CONFIG" && "$(ls -A "$TARGET_CONFIG" 2>/dev/null)" ]]; then
  echo "Backing up existing config to $TARGET_CONFIG.backup"
  rm -rf "$TARGET_CONFIG.backup"
  mv "$TARGET_CONFIG" "$TARGET_CONFIG.backup"
  mkdir -p "$TARGET_CONFIG"
fi

cp -R "$REPO_ROOT"/. "$TARGET_CONFIG"/

PACKER_DIR="$TARGET_CONFIG/pack/packer/start/packer.nvim"
if [[ ! -d "$PACKER_DIR" ]]; then
  echo "Installing Packer..."
  mkdir -p "$(dirname "$PACKER_DIR")"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
fi

nvim --headless -u "$TARGET_CONFIG/init.lua" +"autocmd User PackerComplete quitall" +PackerSync

echo "Done! Your Neovim config is installed at $TARGET_CONFIG"
echo "Run 'nvim' to start editing."
