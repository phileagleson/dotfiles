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

-- Tmux nav --
vim.keymap.set('n','<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Make file executable 
vim.keymap.set('n', '<leader>x',"<cmd>!chmod +x %<CR>", {silent = true})

-- WINDOW NAV
--[[ vim.keymap.set('n', '<c-l>', '<cmd>wincmd l<cr>', nil)
vim.keymap.set('n', '<c-h>', '<cmd>wincmd h<cr>', nil)
vim.keymap.set('n', '<c-j>', '<cmd>wincmd j<cr>', nil)
vim.keymap.set('n', '<c-k>', '<cmd>wincmd k<cr>', nil) ]]

vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>', nil)
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>', nil)

-- BUFFER NAV
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>', nil)
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', nil)

-- TAB NAV
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<cr>', nil)
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<cr>', nil)
vim.keymap.set('n', '<leader>nt', '<cmd>tabnew<cr>', nil)
vim.keymap.set('n', '<leader>nT', '<cmd>wincmd T<cr>', nil) -- open current window in new tab
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:h<cr>', nil) -- change to dir of current open file


-- CLOSING WINDOWS/TABS/BUFFERS
vim.keymap.set('n', '<leader>c', '<cmd>clo<cr>', nil) -- won't close last window
