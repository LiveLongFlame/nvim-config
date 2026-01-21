-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- treesitter
	use{'nvim-treesitter/nvim-treesitter', run=":TSUpdate"}
  	 -- Packer can manage itself
	  use 'wbthomason/packer.nvim'
	  use {
		  'nvim-telescope/telescope.nvim', tag = '0.1.8',
		  -- or                            , branch = '0.1.x',
		  requires = { {'nvim-lua/plenary.nvim'} }
	  }	
	  -- mark down files
	  use {'iamcco/markdown-preview.nvim'}

	  -- csv formater 
	  use{'hat0uma/csvview.nvim'}
	  --color themes
	  use({ 'kepano/flexoki-neovim', as = 'flexoki' })

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

	  -- copiolt
	  use{"github/copilot.vim"}



end)
