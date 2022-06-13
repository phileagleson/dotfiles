vim.o.clipboard = 'unnamedplus'
vim.o.leader = ' '
vim.o.ignorecase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.fileencoding = 'utf-8'
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff=10
vim.o.wrap = false
vim.opt.cot={ 'menu', 'menuone', 'noselect' }

vim.o.background = 'dark'
vim.g.tokyonight_style = 'storm'
pcall(vim.cmd, 'colorscheme tokyonight')

vim.g.mapleader = ' '

-- vimwiki
vim.cmd [[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimmwiki_ext2syntax = { '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_markdown_link_ext = 1
let g:taskwiki_markup_syntax = 'markdown'
let g:markdown_folding = 1
]]

