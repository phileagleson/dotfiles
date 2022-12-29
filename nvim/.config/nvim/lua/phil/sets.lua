vim.opt.guicursor = "n-v-i:block"

vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.syntax = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.swapfile = false
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.fileencoding = 'utf-8'
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.completeopt = 'menuone,noselect'
vim.opt.hlsearch = false
vim.opt.incsearch = true
--vim.o.acd = false

vim.o.background = 'dark'
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.g.mapleader = ' '
--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldcolumn = '2'
-- vimwiki
vim.cmd [[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimmwiki_ext2syntax = { '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_markdown_link_ext = 1
let g:taskwiki_markup_syntax = 'markdown'
set runtimepath+='~/.config/nvim/queries'
set path+='~/projects'
set path+='~/projects/poweron'
]]

--let g:markdown_folding = 1
-- glow
vim.g.glow_binary_path = vim.env.HOME .. "/bin"

-- disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.do_filetype_lua = 1

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
