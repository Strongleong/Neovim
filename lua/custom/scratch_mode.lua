local M = {}

M.state = {
  buf = nil
}

local function create_buf(filetype)
  local dir = vim.fn.stdpath('data') .. '/scratch-mode/'
  local path = dir .. '*scratch*'

  if vim.fn.filereadable(path) then
    vim.fn.delete(path)
  end

  vim.fn.mkdir(dir, 'p')
  local buf = vim.api.nvim_create_buf(true, true)

  vim.api.nvim_buf_set_name(buf, path)
  vim.api.nvim_set_option_value('filetype', filetype or vim.bo.filetype or 'lua', { buf = buf })

  local commentstring = vim.bo[buf].commentstring
  local header = {
    string.format(commentstring, "This is scratch buffer."),
    string.format(commentstring, "If you need to run code in this buffer, use '%' in command mode to substitute it with path to file of this buffer"),
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, header)

  M.state.buf = buf
  return buf
end

function M.open(filetype)
  local buf = M.state.buf or create_buf(filetype)

  vim.api.nvim_win_set_buf(0, buf)

  local line_number = vim.api.nvim_buf_line_count(buf)
  vim.api.nvim_win_set_cursor(0, {line_number, 0})
end

function M.setup()
  vim.api.nvim_create_user_command('Scratch', function (arg)
    M.open(arg.args)
  end, { nargs = '?', complete = 'filetype' })
end

M.setup()

return M
