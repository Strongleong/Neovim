local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  vim.notify("Error. Schemastore is not installed")
  return
end

return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  }
}
