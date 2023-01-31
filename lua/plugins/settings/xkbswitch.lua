vim.g.XkbSwitchEnabled            = 1
vim.g.XkbSwitchIMappings          = {'ru'}
vim.g.XkbSwitchIminsertToggleEcho = 0

if require'custom.lib'.is_windows then
	vim.g.XkbSwitchLib = 'D:\\lib\\libxkbswitch64.dll'
end
