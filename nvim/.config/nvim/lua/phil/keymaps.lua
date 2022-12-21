vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Navigate Quick fix list
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz")

-- Tree --
vim.keymap.set('n', '<leader>n', vim.cmd.Ex, nil)


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
