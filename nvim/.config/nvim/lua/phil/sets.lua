vim.opt.guicursor = "n-v-i:block"

vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.syntax = "on"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.fileencoding = "utf-8"
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.completeopt = "menuone,noselect"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.mouse = ""
vim.o.diffopt = "internal"

vim.o.background = "dark"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.cmd([[
set path+='~/projects'
set path+='~/projects/poweron'
]])

local sysname = os.getenv("SYSNAME")
--local opsystem = string.lower(vim.loop.os_uname().sysname)

if sysname ~= "archie" then
	vim.cmd([[
  let s:xclip = "/bin/xclip"
  let g:clipboard = {
        \  "name" : "xclip",
        \  "copy" : {
        \    "+" : s:xclip.." -sel clip",
        \    "*" : s:xclip.." -sel clip",
        \  },
        \  "paste" : {
        \    "+" : s:xclip.." -o -sel clip",
        \    "*" : s:xclip.." -o -sel clip",
        \  },
        \}
  unlet s:xclip
  ]])
end

vim.g.glow_binary_path = vim.env.HOME .. "/bin"

vim.g.ruby_host_prog = "~/.local/share/gem/ruby/3.0.0/bin/neovim-ruby-host"

vim.g.do_filetype_lua = 1

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
