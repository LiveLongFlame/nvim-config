local template_path = vim.fn.stdpath('config') .. '/templates/cpp_template.cpp'

vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.cpp',
    callback = function()
        vim.cmd('0r ' .. vim.fn.fnameescape(template_path))
    end,
})

