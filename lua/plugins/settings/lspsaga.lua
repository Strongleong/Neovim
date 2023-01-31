local ok, saga = pcall(require, 'lspsaga')
if not ok then
  vim.notify('Error. Lspsaga is not installed')
  return
end

saga.setup({
  symbol_in_winbar = {
    enable = true
  }
})
