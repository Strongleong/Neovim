local M = {}

-- Internal state

local state = {
  buf = nil,
  win = nil,
  original_buf = nil,
  original_win = nil,
  augroup = vim.api.nvim_create_augroup('CompileMode', {}),
  highlight_namespace = vim.api.nvim_create_namespace("compile_highlight"),
  last_prompt = '',
}

-- TODO: opts sanitisaion
local opts = {}

--------------------------------------------------------------------------------
-- Buffer / Window Utility Functions
--------------------------------------------------------------------------------

local function with_buffer_modifiable(buffer, callback)
  vim.api.nvim_set_option_value("modifiable", true, { buf = buffer })
  callback(buffer)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buffer })
end

local function scroll_to_bottom()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    local last_line = vim.api.nvim_buf_line_count(state.buf)
    vim.api.nvim_win_set_cursor(state.win, { last_line, 0 })
  end
end

local function append_to_buffer(buffer, lines)
  if not lines or #lines == 0 then return end

  if lines[#lines] == "" then
    table.remove(lines, #lines)
  end

  local start_line = vim.api.nvim_buf_line_count(buffer)
  with_buffer_modifiable(buffer, function(buf)
    vim.api.nvim_buf_set_lines(buf, start_line, start_line, false, lines)
  end)
  scroll_to_bottom()
end

local function create_compilation_buffer()
  state.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, {})

  vim.api.nvim_set_option_value("modifiable", false, { buf = state.buf })
  vim.api.nvim_set_option_value("filetype", "compilation", { buf = state.buf })

  for key, callback in pairs(opts.keymap) do
    vim.keymap.set('n', key, function() callback() end, { buffer = state.buf })
  end

  state.original_buf = vim.api.nvim_get_current_buf()
  state.original_win = vim.api.nvim_get_current_win()

  state.win = vim.api.nvim_open_win(state.buf, true, { split = opts.window })

  vim.cmd([[
    highlight CompilationFinishError gui=bold guifg=Red
    highlight CompilationFinishSuccess gui=bold guifg=Green
    highlight CompilationRegex gui=underline guifg=Red
  ]])

  vim.cmd("silent! call matchdelete(0)")
  vim.fn.matchadd("CompilationRegex", opts.location_regex, 100, -1, { window = state.win })

  vim.api.nvim_create_autocmd({ "BufDelete", "WinClosed" }, {
    group = state.augroup,
    buffer = state.buf,
    callback = function(args)
      if state.win and vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_close(state.win, true)
      end

      if args.event == "WinClosed" and state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        vim.api.nvim_buf_delete(state.buf, { force = true })
      end

      state.buf = nil
      state.win = nil
    end,
  })
end

--- @return integer
local function get_buffer()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf)
      or not state.win or not vim.api.nvim_win_is_valid(state.win) then
    create_compilation_buffer()
  end

  with_buffer_modifiable(state.buf, function(buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Compilation started at " .. os.date("%a %b %d %H:%M:%S"), "" })
  end)

  return state.buf
end

--------------------------------------------------------------------------------
-- Job Callbacks
--------------------------------------------------------------------------------

--- Handle standard output and error from the job.
local function handle_job_output(buffer, data)
  if data then
    append_to_buffer(buffer, data)
  end
end

--- Handle exit callback for the job.
local function handle_job_exit(buffer, exit_code)
  local status_str = (exit_code == 0)
      and "ended"
      or ("exited abnormally with code " .. exit_code)
  local exit_line = "Compilation " .. status_str .. " at " .. os.date("%a %b %d %H:%M:%S")
  append_to_buffer(buffer, { "", exit_line })

  local last_line = vim.api.nvim_buf_line_count(buffer) - 1
  local search_text = (exit_code == 0) and "ended" or "exited abnormally"
  local start_idx, end_idx = exit_line:find(search_text)

  if start_idx and end_idx then
    vim.api.nvim_buf_set_extmark(buffer, state.highlight_namespace, last_line, start_idx - 1, {
      end_col = end_idx,
      hl_group = (exit_code == 0) and "CompilationFinishSuccess" or "CompilationFinishError",
    })
  end

  if exit_code ~= 0 then
    local code_str = tostring(exit_code)
    local code_start = exit_line:find(code_str, end_idx + 1, true)
    if code_start then
      vim.api.nvim_buf_set_extmark(buffer, state.highlight_namespace, last_line, code_start - 1, {
        end_col = code_start - 1 + #code_str,
        hl_group = "CompilationFinishError",
      })
    end
  end
end

--------------------------------------------------------------------------------
-- Plugin module
--------------------------------------------------------------------------------

function M.compile_close()
  vim.api.nvim_buf_delete(state.buf, { force = true })
end

function M.compile_open_location()
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    vim.notify("Compilation buffer is not available", vim.log.levels.ERROR)
    return
  end

  if not state.win or not vim.api.nvim_win_is_valid(state.win) then
    vim.notify("Compilation window is not available", vim.log.levels.ERROR)
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(state.win)
  local line_num = cursor[1]
  local line = vim.api.nvim_buf_get_lines(state.buf, line_num - 1, line_num, false)[1]

  if not line then
    vim.notify("No line under cursor.", vim.log.levels.WARN)
    return
  end

  local matched = vim.fn.matchstr(line, opts.location_regex)
  if matched == "" then
    vim.notify("No location found on the line.", vim.log.levels.WARN)
    return
  end

  local file, lnum, col = string.match(matched, "([^:]+):(%d+):?(%d*)")
  if not file or not lnum then
    vim.notify("Failed to parse location: " .. matched, vim.log.levels.ERROR)
    return
  end

  lnum = tonumber(lnum)
  col = col and tonumber(col) or 1

  if state.original_win and vim.api.nvim_win_is_valid(state.original_win) then
    vim.api.nvim_set_current_win(state.original_win)
    if vim.api.nvim_buf_get_name(state.original_buf) ~= vim.fn.fnameescape(file) then
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end
  else
    vim.cmd("vsplit " .. vim.fn.fnameescape(file))
  end

  vim.api.nvim_win_set_cursor(0, { lnum, col - 1 })
end

function M.recompile()
  M.compile(state.last_prompt)
end

function M.compile(cmd)
  local buffer = get_buffer()
  append_to_buffer(buffer, { cmd })

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data, _)
      handle_job_output(buffer, data)
    end,

    on_stderr = function(_, data, _)
      handle_job_output(buffer, data)
    end,

    on_exit = function(_, exit_code, _)
      handle_job_exit(buffer, exit_code)
    end,
  })
end

local default_opts = {
  window = 'below',
  location_regex = [[\v((\S*/\S+)|(\S+\.\S+)):(\d+)(:(\d+))?]],
  keymap = {
    ['q'] = M.compile_close,
    ['<Esc>'] = M.compile_close,
    ['<CR>'] = M.compile_open_location,
    ['o'] = M.compile_open_location,
    ['g'] = M.recompile,
  }
}

function M.setup(user_opts)
  opts = vim.tbl_deep_extend("force", {}, default_opts, user_opts or {})

  vim.api.nvim_create_user_command('Compile', function(ctx)
    local cmd = ctx.args

    if cmd == "" then
      cmd = vim.fn.input({
        prompt = "Compile command: ",
        default = state.last_prompt,
        completion = 'shellcmdline',
        cancelreturn = ''
      })
      state.last_prompt = cmd

      if cmd == "" then
        vim.notify("No command provided.", vim.log.levels.WARN)
        return
      end
    end

    M.compile(cmd)
  end, { nargs = '*', complete = 'shellcmdline' })
end

return M
