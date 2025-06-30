vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>jt", function()
	local dir = vim.fn.expand('%:p:h')
	vim.cmd("sp")
	vim.cmd("wincmd j")
	vim.cmd("lcd " .. dir)       -- change local dir for the terminal window
	vim.cmd("terminal")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>lt", function()
	local dir = vim.fn.expand('%:p:h')
	vim.cmd("vsp")
	vim.cmd("wincmd l")
	vim.cmd("lcd " .. dir)       -- change local dir for the terminal window
	vim.cmd("terminal")
end, { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Create a custom user command
vim.api.nvim_create_user_command("VSplit70Left", function()
  vim.cmd("vsp")                  -- Open vertical split (right window)
  vim.cmd("wincmd h")            -- Move to the left window
  local total_width = vim.o.columns
  local left_width = math.floor(total_width * 0.6)
 vim.cmd("vertical resize " .. left_width)
end, {})

-- Map <leader>s73 to the command
vim.keymap.set("n", "<leader>73", ":VSplit70Left<CR>", { noremap = true, silent = true })

