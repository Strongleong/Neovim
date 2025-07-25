return {
  filetypes = { 'php', 'inc' },
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
        associations = { "*.php", "*.phtml", "*.inc" },
      },
      environment = {
        phpVersion = "8.0.5",
        shortOpenTag = false,
        includePaths = {
          "/home/strongleong/projects/sakh.com/core/system.php",
          "/home/strongleong/projects/sakh.com/core/src",
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
