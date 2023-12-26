vim.g.mapleader = ' '

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, {})

