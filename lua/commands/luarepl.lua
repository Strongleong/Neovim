local function lua_repl(args)
  vim.cmd("lua print(vim.inspect(" .. args.args .. "))")
end

vim.api.nvim_create_user_command('Lua', lua_repl, { nargs = '*'})
