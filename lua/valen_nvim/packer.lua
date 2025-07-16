-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  	 -- Packer can manage itself
	  use 'wbthomason/packer.nvim'
	  use {
		  'nvim-telescope/telescope.nvim', tag = '0.1.8',
		  -- or                            , branch = '0.1.x',
		  requires = { {'nvim-lua/plenary.nvim'} }
	  }	
	  --color themes
	  use("vague2k/vague.nvim")
	  use ("bluz71/vim-moonfly-colors")
	  use ("rebelot/kanagawa.nvim")
	  use("dgox16/oldworld.nvim")
	

	  use {
		  'nvim-treesitter/nvim-treesitter',
		  run = function()
			  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			  ts_update()
		  end,
	  }

	  use('nvim-lua/plenary.nvim')
	  use('ThePrimeagen/harpoon')
	  use('mbbill/undotree')
	  --lsp config
	  use("mason-org/mason-lspconfig.nvim")
	  use("mason-org/mason.nvim")
	  use("neovim/nvim-lspconfig")
	  use("hrsh7th/nvim-cmp")
	  use("hrsh7th/cmp-nvim-lsp")

	  --lualine 
	  use {
		  'nvim-lualine/lualine.nvim',
		  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	  }
	  --Commenting
	  use {
		  'numToStr/Comment.nvim',
		  config = function()
			  require('Comment').setup()
		  end
}

end)
