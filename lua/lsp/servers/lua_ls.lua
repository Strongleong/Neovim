-- TODO: Add LuaLine globals only for files in snippets folder

return {
  settings = {
    Lua = {
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
      }
    }
  }
}
