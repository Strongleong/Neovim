vim.api.nvim_create_user_command('Lua', function (args)
  vim.cmd("lua print(vim.inspect(" .. args.args .. "))")
end, { nargs = '*'})
