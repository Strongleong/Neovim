local vue_typescript_plugin = require('mason-registry')
    .get_package('vue-language-server')
    :get_install_path()
    .. '/node_modules/@vue/language-server'
    .. '/node_modules/@vue/typescript-plugin'

return {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_typescript_plugin,
        languages = { 'javascript', 'typescript', 'vue' }
      },
    }
  },
  filetypes = {
    "javascript",
    "vue",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  }
}
