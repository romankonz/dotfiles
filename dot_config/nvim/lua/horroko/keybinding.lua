vim.g.mapleader = ' '

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fi', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, {})

vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, {})

vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>es', ':NvimTreeFindFile<CR>', {})
