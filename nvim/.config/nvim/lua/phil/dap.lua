local ok, _ = pcall(require, 'dap')
if not ok then
  print('Dap failed to load' .. ok)
  return
end

vim.keymap.set('n', '<F5>', ':lua require"dap".continue()<cr>')
vim.keymap.set('n', '<F3>', ':lua require"dap".step_over()<cr>')
vim.keymap.set('n', '<F2>', ':lua require"dap".step_into()<cr>')
vim.keymap.set('n', '<F12>', ':lua require"dap".step_out()<cr>')
vim.keymap.set('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<cr>')
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

require('nvim-dap-virtual-text').setup()
require('dap-go').setup()
require('dapui').setup()

local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require 'mason-nvim-dap'.setup {
  ensure_installed = { 'node2', 'chrome', }
}
