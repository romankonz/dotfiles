vim.g.mapleader = ' '

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fi', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, {})
vim.keymap.set('n', '<leader>fm', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>fu', builtin.git_stash, {})

vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, {})

vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>es', ':NvimTreeFindFile<CR>', {})

vim.keymap.set('n', '<leader>gl', function() vim.cmd.Git('pull') end, {})
vim.keymap.set('n', '<leader>gp', function() vim.cmd.Git('push') end, {})
vim.keymap.set('n', '<leader>gs', function() vim.cmd.Git('status') end, {})
vim.keymap.set('n', '<leader>gc', function() vim.cmd.Git('commit') end, {})
vim.keymap.set('n', '<leader>gd', function() vim.cmd.Git('diff') end, {})
vim.keymap.set('n', '<leader>gb', function() vim.cmd.Git('blame') end, {})
vim.keymap.set('n', '<leader>gg', function() vim.cmd.Git() end, {})
