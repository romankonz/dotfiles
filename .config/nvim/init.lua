-- map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install and setup plugins
require('lazy').setup({
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-sleuth' },
  { "github/copilot.vim" },
  { "luckasRanarison/tree-sitter-hyprlang" },
  { 'fladson/vim-kitty' },
  {
    'folke/tokyonight.nvim',
    style = 'day',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',          config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim',                opts = {} },
      { 'folke/neodev.nvim' },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
    },
  },
  { 'folke/which-key.nvim',    opts = {} },
  { 'lewis6991/gitsigns.nvim', opts = {} },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {}
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { 'numToStr/Comment.nvim',               opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ':TSUpdate',
  },
  { 'dhruvasagar/vim-table-mode' },
  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    opts = {
      workspaces = {
        --{
        --  name = 'horroko',
        --  path = '/Users/rk/Library/Mobile Documents/iCloud~md~obsidian/Documents/Horroko/',
        --},
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    }
  },
})

-- vim options

vim.o.hlsearch = false

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true
vim.o.smartindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

vim.g.table_mode_corner = '|'


-- basic keymaps

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- leader keymaps

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fi', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fu', builtin.git_stash, {})
vim.keymap.set('n', '<leader>fo', ':ObsidianSearch<CR>', {})
vim.keymap.set('n', '<leader>fv', builtin.registers, {})

vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>es', ':NvimTreeFindFile<CR>', {})

vim.keymap.set('n', '<leader>gl', function() vim.cmd.Git('pull') end, {})
vim.keymap.set('n', '<leader>gp', function() vim.cmd.Git('push') end, {})
vim.keymap.set('n', '<leader>gs', function() vim.cmd.Git('status') end, {})
vim.keymap.set('n', '<leader>gc', function() vim.cmd.Git('commit') end, {})
vim.keymap.set('n', '<leader>gd', function() vim.cmd.Git('diff') end, {})
vim.keymap.set('n', '<leader>gb', function() vim.cmd.Git('blame') end, {})
vim.keymap.set('n', '<leader>gg', function() vim.cmd.Git() end, {})

vim.keymap.set('n', '<leader>oo', ':ObsidianOpen<CR>', {})

vim.keymap.set('n', '<leader>tt', ':TableModeToggle<CR>', {})

-- treesitter

vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'bash',
      'go',
      'lua',
      'python',
      'vim',
      'hyprlang'
    },
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
  }
end, 0)

-- LSP
local on_attach = function(_, _)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
  vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

  vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
  vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, {})
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
  vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
  vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, {})
  vim.keymap.set('n', '<leader>fm', builtin.lsp_implementations, {})
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, {})
  vim.keymap.set({ 'v', 'n' }, '<leader>ra', vim.lsp.buf.code_action, {})
end

require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  gopls = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  docker_compose_language_service = {},
  dockerls = {},
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup(_, _)
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "[h]arpoon [a]dd" })
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
