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

require('lazy').setup({
  'nvim-lua/popup.nvim', 
  'nvim-lua/plenary.nvim', 
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },
  'stevearc/oil.nvim',

  'christoomey/vim-tmux-navigator',

  {
  'exafunction/codeium.vim',
   config = function()
    vim.keymap.set('i', '<c->>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<c-<>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  'mbbill/undotree',

  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/playground',
  {
    'windwp/nvim-autopairs', 
    config = function() require 'nvim-autopairs'.setup {} end
  },

  'folke/todo-comments.nvim',
  'kyazdani42/nvim-web-devicons',

  -- Colorschemes
  'navarasu/onedark.nvim',
  'folke/tokyonight.nvim',
  'EdenEast/nightfox.nvim',
  { 'catppuccin/nvim', as = 'catppuccin' },
  'marko-cerovac/material.nvim',

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  'nvim-telescope/telescope-ui-select.nvim',

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },

  'nvim-telescope/telescope-file-browser.nvim',

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  -- Not sure if this is still needed
  {
    'kosayoda/nvim-lightbulb',
    dependencies = 'antoinemadec/FixCursorHold.nvim'
  },
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lua',
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  'saadparwaiz1/cmp_luasnip',
  'tamago324/cmp-zsh',

  -- DAP: debugging
  'mfussenegger/nvim-dap',
  'jayp0521/mason-nvim-dap.nvim',
  'leoluz/nvim-dap-go',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',

  -- STATUSLINE
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  -- COLOR PREVIEW
  'norcalli/nvim-colorizer.lua',

  -- STATUSLINE
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },

  -- comments
  {
    'numToStr/Comment.nvim',
    config = function()
      require 'Comment'.setup()
    end
  },

  -- COLOR PREVIEW
  'norcalli/nvim-colorizer.lua',

  -- VIMWIKI
 {
    "vimwiki/vimwiki",
    branch = "dev",
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/",
          syntax = "markdown",
          ext = ".md",
        },
      }
    end,
  },
   
 -- Toggleterm
  'akinsho/toggleterm.nvim',

  -- Caps Lock for Poweron
  'barklan/capslock.nvim',

  'jose-elias-alvarez/null-ls.nvim',
  'jayp0521/mason-null-ls.nvim',

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',
  'tpope/vim-surround',
  'theprimeagen/harpoon',

  "rcarriga/nvim-notify",
  { 'j-hui/fidget.nvim', tag = 'legacy', opts = {
    window = { blend = 80,},
    fmt = { max_width = 80, },
  } },
  'folke/neodev.nvim',

  'rebelot/kanagawa.nvim'
})
