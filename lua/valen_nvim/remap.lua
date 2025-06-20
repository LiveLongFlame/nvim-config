vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ot", function()
  local dir = vim.fn.expand('%:p:h')
  vim.cmd("vsp")
  vim.cmd("wincmd l")
  vim.cmd("lcd " .. dir)       -- change local dir for the terminal window
  vim.cmd("terminal")
end, { noremap = true, silent = true })

