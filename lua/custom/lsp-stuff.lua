local M = {}

M.lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    bufnr = bufnr,
    async = true,
    filter = function(client)
      for _, x in pairs(vim.lsp.get_active_clients()) do
        print(x.name)
        if x.name == 'null-ls' then
          return client.name == 'null-ls'
        end
      end

      return true
    end
  })
end

return M
