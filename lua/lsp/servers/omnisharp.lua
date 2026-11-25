local pid = vim.fn.getpid()
local util = require 'lspconfig.util'

return {
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = util.root_pattern(
      '*.sln',
      '*.csproj',
      'Makefile'
    )(fname)

    on_dir(root or vim.fs.dirname(fname))
  end,
}
