-- Always reserve space for sign column to avoid layout shift
vim.opt.signcolumn = 'no'

-- Optional: keep the command line height minimal
vim.opt.cmdheight = 1

-- Disable inline diagnostic virtual text (the messages on the right)
vim.diagnostic.config({
	virtual_text = false,
	signs = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Enhance LSP capabilities for nvim-cmp before any LSP servers are set up
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

-- Setup LSP keybindings only when LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'x' }, '<F3>', function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
	end,
})

-- Setup nvim-cmp for autocompletion
local cmp = require('cmp')

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	}),
	sources = {
		{ name = 'nvim_lsp' },
	},
	snippet = {
		expand = function(args)
			-- Requires Neovim v0.10+
			vim.snippet.expand(args.body)
		end,
	},
})

-- Setup Mason and LSP servers
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { 'lua_ls', 'rust_analyzer', 'cssls', 'pyright', 'clangd', 'html', 'eslint' },
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
})

