local schemas = {}
local status_ok, schemastore = pcall(require, "schemastore")
if status_ok then
  schemas = schemastore.yaml.schemas()
end

return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = schemas,
    },
  },
}
