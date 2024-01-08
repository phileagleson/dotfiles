return {
    "barklan/capslock.nvim",
    config = function()
        require("capslock").setup()
        vim.keymap.set({ 'i', 'c', 'n' }, '<C-g>c', '<Plug>CapsLockToggle')
        vim.keymap.set('i', '<C-l>', '<Plug>CapsLockToggle')
    end,
}
