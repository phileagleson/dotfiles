--[[ local group = vim.api.nvim_create_augroup('Format', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', { command = ':lua vim.lsp.buf.format()', group = group }) ]]


local group = vim.api.nvim_create_augroup('Format', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = "*.rs",
  command = ':lua vim.lsp.buf.format()',
  group = group
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local indentGroup = vim.api.nvim_create_augroup('PoweronIndents', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'poweron',
  callback = function()
    vim.opt_local.shiftwidth = 1
    vim.opt_local.tabstop = 1
    vim.opt.foldmethod = 'expr'
    vim.opt.colorcolumn = "132"
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldcolumn = '2'
    require('capslock').toggle('n')
  end,
  group = indentGroup,
})


local foldGroup = vim.api.nvim_create_augroup('OpenFolds', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType', 'BufReadPost', 'FileReadPost' }, {
  pattern = 'poweron',
  callback = function()
    vim.api.nvim_command('normal zR')
  end,
  group = foldGroup,
})

-- Open Telescope when opened without arguments
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
   if #vim.fn.argv() == 0 then 
     vim.defer_fn(function() 
       vim.cmd("silent! lua require('telescope.builtin').find_files()")
    end, 500)
   end
  end,
})
