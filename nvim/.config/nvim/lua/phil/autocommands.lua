local group = vim.api.nvim_create_augroup('Format', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', { command = ':lua vim.lsp.buf.format()', group = group })

local lggroup = vim.api.nvim_create_augroup('LGLoad', {clear = true })
vim.api.nvim_create_autocmd('BufEnter', { command = 'lua require("lazygit.utils").project_root_dir()', group=lggroup})
