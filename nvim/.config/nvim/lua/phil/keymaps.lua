-- TELESCOPE --
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', nil)
vim.keymap.set('n', '<leader>lg', '<cmd>Telescope live_grep<cr>', nil)
vim.keymap.set('n', '<leader>n', '<cmd>NERDTreeToggle<cr>', nil)


-- WINDOW NAV
vim.keymap.set('n', '<c-l>', '<cmd>wincmd l<cr>', nil)
vim.keymap.set('n', '<c-h>', '<cmd>wincmd h<cr>', nil)
vim.keymap.set('n', '<c-j>', '<cmd>wincmd j<cr>', nil)
vim.keymap.set('n', '<c-k>', '<cmd>wincmd k<cr>', nil)

-- BUFFER NAV
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>', nil)
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', nil)

-- TAB NAV
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<cr>', nil)
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<cr>', nil)
vim.keymap.set('n', '<leader>nt', '<cmd>tabnew<cr>', nil)
vim.keymap.set('n', '<leader>nT', '<cmd>wincmd T<cr>', nil) -- open current window in new tab


-- CLOSING WINDOWS/TABS/BUFFERS
vim.keymap.set('n', '<leader>c', '<cmd>clo<cr>', nil) -- won't close last window

