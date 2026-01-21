require("nvim-treesitter").setup({
  -- Parsers you want installed
  ensure_installed = {
    "c",
    "cpp",
    "python",
    "lua",
    "bash",
    "json",
    "html",
    "css",
    "javascript",
  },

  -- Install missing parsers automatically
  auto_install = true,

  highlight = {
    enable = true,

    -- Disable for very large files if needed
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
})

