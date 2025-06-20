vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ht", function()
  local dir = vim.fn.expand('%:p:h')
  vim.cmd("sp")
  vim.cmd("wincmd j")
  vim.cmd("lcd " .. dir)       -- change local dir for the terminal window
  vim.cmd("terminal")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>vt", function()
  local dir = vim.fn.expand('%:p:h')
  vim.cmd("vsp")
  vim.cmd("wincmd l")
  vim.cmd("lcd " .. dir)       -- change local dir for the terminal window
  vim.cmd("terminal")
end, { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

