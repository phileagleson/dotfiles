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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
    --[[ vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
--[[ local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end ]]

-- Have packer use a popup window
--[[ packer.init {
  max_jobs = 10,
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
} ]]

-- Install your plugins here
--return packer.startup(function(use)
require('lazy').setup({
  'nvim-lua/popup.nvim', -- An implementation of the Popup API from vim in Neovim
  'nvim-lua/plenary.nvim', -- Useful lua functions used ny lots of plugins
  {
    'nvim-treesitter/nvim-treesitter',
    --build = ":TSUpdate",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },
  'stevearc/oil.nvim',

  {
  'exafunction/codeium.vim',
   config = function()
    vim.keymap.set('i', '<c->>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<c-<>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  --[[ {
    "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("chatgpt").setup({
          api_key_cmd = "pass show chatgptapi",
      })
      end,
  }, ]]

  'mbbill/undotree',

  'nvim-treesitter/nvim-treesitter-context',
  'nvim-treesitter/playground',
  {
    'windwp/nvim-autopairs', -- Autopairs, integrates with both cmp and treesitter
    config = function() require 'nvim-autopairs'.setup {} end
  },

  'p00f/nvim-ts-rainbow',
  'folke/todo-comments.nvim',
  'kyazdani42/nvim-web-devicons',

  -- Colorschemes
  'navarasu/onedark.nvim',
  'folke/tokyonight.nvim',
  'EdenEast/nightfox.nvim',
  { 'catppuccin/nvim', as = 'catppuccin' },

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

  -- Grammar Checking
  'rhysd/vim-grammarous',

  -- Native LSP
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  {
    'kosayoda/nvim-lightbulb',
    dependencies = 'antoinemadec/FixCursorHold.nvim'
  },
  --'williamboman/nvim-lsp-installer',

  -- LSP Autocompletion
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
  'vimwiki/vimwiki',

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
  -- vim surround
  'tpope/vim-surround',
  -- PLUGINS I'M WORKING ON
  --    '~/projects/poweron-nvim',
  'theprimeagen/harpoon',

  -- MDX
  'jxnblk/vim-mdx-js',

  --[[ if packer_bootstrap then
    require('packer').sync()
  end ]]
})
