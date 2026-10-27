require("mason").setup()

require("mason-lspconfig").setup({
	automatic_enable = { "lua_ls", "vimls", "clangd", "basedpyright", "ast-grep" },
})

require("lspconfig").util.default_config.capabilities =
	require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
	end,
})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = { { name = "nvim_lsp" } },
})
