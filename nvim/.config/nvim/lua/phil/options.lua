vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.syntax = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
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
vim.opt.cot = { 'menu', 'menuone', 'noselect' }
vim.o.acd = true

vim.o.background = 'dark'
vim.g.mapleader = ' '
--vim.opt.foldmethod = 'expr'
--vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

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
