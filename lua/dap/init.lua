-- NOTE: To lazy to setup DAP yet
local ok
local dap

ok, dap = pcall(require, 'dap.ext.vscode')
if not ok then
  vim.notify('Error. DAP is not installed')
  return
end

dap.load_launchjs('dap.json')

require('plugins.settings.dap.nvim-dap-ui')
require('plugins.settings.dap.nvim-dap-virtual-text')

