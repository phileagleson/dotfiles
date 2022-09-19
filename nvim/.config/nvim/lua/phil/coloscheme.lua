vim.g.catppuccin_flavour = 'mocha'
require('catppuccin').setup {
    integrations = {
        'nvim-treesitter' == true,
        'nvim-treesitter-context' == true,
        'telescope.nvim' == true,
        'vimwiki' == true,
    }
}

vim.cmd [[colorscheme catppuccin]]
