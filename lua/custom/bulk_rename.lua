local api = require("nvim-tree.api")
local nodes = api.marks.list()
local files = {}
local rename = require'nvim-tree.actions.fs.rename-file'.rename

for _, file in pairs(nodes) do
  table.insert(files, file.absolute_path)
end

local hBuf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(hBuf, 0, -1, true, files)
vim.cmd("below split")
vim.api.nvim_set_current_buf(hBuf)

vim.api.nvim_create_autocmd("WinClosed", {
  buffer = hBuf,
  callback = function ()
    local newFiles = vim.api.nvim_buf_get_lines(hBuf, 0, -1, false)
    vim.api.nvim_buf_delete(hBuf, {})

    for i, node in pairs(nodes) do
      rename(node, newFiles[i])
    end
  end
})
