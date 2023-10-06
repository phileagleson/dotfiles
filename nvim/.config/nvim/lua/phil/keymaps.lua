vim.keymap.del('n','<C-H>')
vim.keymap.set('n', '<C-H>', ':<C-U>TmuxNavigateLeft<cr>',{silent=true, noremap=true})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- Navigate Quick fix list
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz")

-- Tree --
vim.keymap.set(
  'n', 
  '<leader>n', 
  ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
  {noremap=true}
)

-- Tmux nav --
vim.keymap.set('n','<C-f>', "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set({'n','v'},'<leader>q', "<cmd>silent !jqpaste<CR>P:%!jq .<CR>")

-- Make file executable 
vim.keymap.set('n', '<leader>x',"<cmd>!chmod +x %<CR>", {silent = true})

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

