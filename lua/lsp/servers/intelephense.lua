local opts = {
  filetypes = { 'php', 'inc' },
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
        associations = { "*.php", "*.phtml", "*.inc" },
      },
      environment = {
        phpVersion = "8.3",
        shortOpenTag = false,
        includePaths = {},
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

if string.find(vim.fn.getcwd(), "sakh.com") then
  opts.settings.intelephense.environment.includePaths = {"/home/strongleong/projects/sakh.com/core/",}
end

return opts
