M = {}

local state = {
  win = nil,
  buf = nil,
  original_win = nil
}

local options = {}

local function open_regex_buffer()
  if state.buf ~= nil then
    vim.api.nvim_buf_delete(state.buf, { force = true })
  end

  local buffer = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_name(buffer, "Regex")

  state.buf = buffer
  return buffer
end

local function open_regex_window(buffer)
  state.original_win = vim.api.nvim_get_current_win()
  local win = vim.api.nvim_open_win(buffer, true, { split = 'below' })

  state.win = win
  return win
end

function M.open()
  local buffer = open_regex_buffer()
  open_regex_window(buffer)
end

function M.setup(opts)
  if opts then
    options = vim.tbl_deep_extend("force", options, opts)
  end
end

M.open()

return M
