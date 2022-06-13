local fn = vim.fn



local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    max_jobs = 10,
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
    use 'nvim-lua/plenary.nvim' -- Useful lua functions used ny lots of plugins
    use {
        'nvim-treesitter/nvim-treesitter',
         run = ":TSUpdate",
    }
    use {
        'windwp/nvim-autopairs', -- Autopairs, integrates with both cmp and treesitter
        config = function() require'nvim-autopairs'.setup{} end
    }
    use 'folke/todo-comments.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- Colorschemes
    use 'folke/tokyonight.nvim'
    use 'lunarvim/colorschemes' -- A bunch of colorschemes you can try out
    use 'lunarvim/darkplus.nvim'
    use 'rose-pine/neovim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    }

    use 'nvim-telescope/telescope-file-browser.nvim'


    -- Grammar Checking
    use 'rhysd/vim-grammarous'

    -- Native LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    -- LSP Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    
    -- DAP: debugging
    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

    -- NERDTree
    use 'preservim/nerdtree'

    -- STATUSLINE
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require'Comment'.setup()
        end
    }

    -- VIMWIKI
    use 'vimwiki/vimwiki'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
