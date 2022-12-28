local group = vim.api.nvim_create_augroup('Format', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', { command = ':lua vim.lsp.buf.format()', group = group })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local indentGroup = vim.api.nvim_create_augroup('PoweronIndents', { clear = true })
vim.api.nvim_create_autocmd('FileType poweron', {
  buffer = 0,
  callback = function()
    vim.opt_local.shiftwidth = 1
    vim.opt_local.tabstop = 1
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldcolumn = '2'
    require('capslock').toggle('n')
  end,
  group = indentGroup,
})

local foldGroup = vim.api.nvim_create_augroup('PoweronFolds', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType poweron', 'BufReadPost,FileReadPost' }, {
  buffer = 0,
  callback = function()
    vim.api.nvim_command('normal zR')
  end,
  group = foldGroup,
})
