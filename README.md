# nvim-config

A personal Neovim config for Lua editing, C/C++, Python, LSP, and general dev workflows.

## Quick start

Windows (PowerShell):

```powershell
./setup.ps1
```

Linux/macOS:

```bash
bash ./setup.sh
```

The setup script will:
- install Neovim if needed
- install common dev tooling (ripgrep, fd, npm, git when available)
- install Packer if missing
- copy this config into your Neovim config directory
- run `:PackerSync` so all plugins install automatically
- open Neovim with the config ready to use

## Manual install

If you want to do it yourself:

1. Install Neovim
2. Clone this repo into your Neovim config folder:
   - Windows: `%LOCALAPPDATA%\nvim`
   - Linux/macOS: `~/.config/nvim`
3. Start Neovim and run:

```vim
:PackerSync
```

## Included features

- Telescope file search and grep
- Harpoon quick file switching
- Undotree
- Lualine statusline
- Treesitter syntax highlighting
- LSP setup via Mason + nvim-lspconfig
- Markdown preview
- CSV view
- Flexoki theme
- custom keymaps for terminal splits and file navigation

## Useful keymaps

- `<leader>pv` - open file explorer
- `<leader>pf` - Telescope find files
- `<C-p>` - Telescope git files
- `<leader>ps` - Telescope grep
- `<leader>a` - Harpoon add file
- `<C-e>` - Harpoon menu
- `<leader>u` - Undotree toggle
- `<F2>` - rename symbol
- `<F3>` - format buffer
- `<F4>` - code actions

## Notes

- `markdown-preview.nvim` expects Node/npm to be available.
- `ripgrep` and `fd` improve Telescope search performance and are recommended.
- If you see plugin warnings after first install, restart Neovim and run `:PackerSync` once more.
