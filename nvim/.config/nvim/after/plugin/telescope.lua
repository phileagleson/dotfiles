require('telescope').setup {
}

require('telescope').load_extension('fzf')


vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', nil)
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', nil)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', nil)
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', nil)
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', nil)
