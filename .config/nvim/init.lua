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
  { 'folke/which-key.nvim',
    opts = {},
    dependencies = {
      { 'echasnovski/mini.nvim', version = false }
    }
  },
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  }
})

-- vim options

vim.o.hlsearch = false

vim.wo.number = true
vim.wo.relativenumber = true

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

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]ile'})
vim.keymap.set('n', '<leader>fi', builtin.live_grep, { desc = '[f]ind [i]n files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[f]ind [g]it files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind [b]uffer' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp' })
vim.keymap.set('n', '<leader>fu', builtin.git_stash, { desc = '[f]ind ([u]n)stash' })
vim.keymap.set('n', '<leader>fv', builtin.registers, { desc = '[f]ind [v] registers' })

vim.keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>', { desc = '[e]xplorer [e]xpand'})
vim.keymap.set('n', '<leader>es', ':NvimTreeFindFile<CR>', { desc = '[e]xplorer [s]earch'})

vim.keymap.set('n', '<leader>gl', function() vim.cmd.Git('pull') end, { desc = '[g]it pu[l]l' })
vim.keymap.set('n', '<leader>gp', function() vim.cmd.Git('push') end, { desc = '[g]it [p]ush' })
vim.keymap.set('n', '<leader>gs', function() vim.cmd.Git('status') end, { desc = '[g]it [s]tatus'})
vim.keymap.set('n', '<leader>gc', function() vim.cmd.Git('commit') end, { desc = '[g]it [c]ommit'})
vim.keymap.set('n', '<leader>gd', function() vim.cmd.Git('diff') end, { desc = '[g]it [d]iff'})
vim.keymap.set('n', '<leader>gb', function() vim.cmd.Git('blame') end, { desc = '[g]it [b]lame'})
vim.keymap.set('n', '<leader>gg', function() vim.cmd.Git() end, { desc = '[g]it [g]it'})

vim.keymap.set('n', '<leader>tt', ':TableModeToggle<CR>', { desc = '[t]able [t]oggle' })

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
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'show [K]ind' })
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = '[g]oto [d]efinition' })
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = '[g]oto [D]eclaration' })
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = '[g]oto [i]mplementation' })
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = '[g]oto [o]bject' })
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = '[g]oto [r]eferences' })
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = '[g]oto [s]ignature' })
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'rename buffer' })
  vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = 'format buffer' })
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'code action' })

  vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = '[f]ind [s]ymbols'})
  vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, { desc = '[f]ind [w]orkspace symbols'})
  vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = '[f]ind [r]eferences'})
  vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = '[f]ind [d]efinitions'})
  vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, { desc = '[f]ind [t]ype definitions'})
  vim.keymap.set('n', '<leader>fm', builtin.lsp_implementations, { desc = '[f]ind i[m]plementations'})
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, { desc = '[r]efactor [r]ename'})
  vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, { desc = '[r]efactor [f]ormat'})
  vim.keymap.set({ 'v', 'n' }, '<leader>ra', vim.lsp.buf.code_action, { desc = '[r]efactor [a]ction'})
end

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
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[h]arpoon [h]ome" })

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "[h]arpoon [1]" })
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "[h]arpoon [2]" })
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "[h]arpoon [3]" })
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(4) end, { desc = "[h]arpoon [4]" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "[h]arpoon [p]revious" })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "[h]arpoon [n]ext" })
