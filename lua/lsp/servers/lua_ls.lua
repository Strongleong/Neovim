-- TODO: Add LuaLine globals only for files in snippets folder

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '~/.local/share/nvim/lazy/dracula',
        },
      },
      diagnostics = {
        globals = {
          'vim',
          'ls',
          's',
          'sn',
          'isn',
          't',
          'i',
          'f',
          'c',
          'd',
          'r',
          'events',
          'ai',
          'extras',
          'l',
          'rep',
          'p',
          'm',
          'n',
          'dl',
          'fmt',
          'fmta',
          'conds',
          'postfix',
          'types',
          'parse',
          'ms',
          'k',
        }
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
      },
      completion = {
        callSnippet = 'Replace',
      },
    }
  }
}
