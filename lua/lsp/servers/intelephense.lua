return {
  filetypes = { 'php', 'inc' },
  settings = {
    intelephense = {
      files = {
        maxSize = 1000000000,
        associations = {"*.php","*.phtml", "*.inc"},
      },
      environment = {
        phpVersion = "8.3",
        shortOpenTag = false,
        includePath = {
          "/home/strongleong/projects/sakh.com/core/"
        },
      },
      telemetry = {
        enabled = false,
      },
      phpdoc = {
        returnVoid = false,
      },
      stubs = {
        "/home/strongleong/soft/phpstorm-stubs",
      }
    }
  }
}
