local pid = vim.fn.getpid()
local util = require'lspconfig.util'

return {
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
  root_dir = function (fname)
    return util.root_pattern('*.sln', '*.csproj', 'Makefile')(fname) or util.path.dirname(fname)
  end,
}
