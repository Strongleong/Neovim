local state = {
  buf = nil,
  win = nil,
}

local augroup = vim.api.nvim_create_augroup('CompileMode', {})
local ns_id = vim.api.nvim_create_namespace("compile_highlight")
local last_prompt = ''

local function temp_unlock_buf(buf, callback)
  vim.api.nvim_set_option_value("modifiable", true, {})
  callback(buf)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

local function add_highlighting(buf)
  vim.cmd([[
    highlight CompilationError gui=bold guifg=Red
    highlight CompilationFinish gui=bold guifg=Green
    highlight CompilationFile gui=underline guifg=Red
  ]])

  vim.cmd("silent! call matchdelete(0)")
  vim.fn.matchadd("CompilationFile", [[\v((\S*/\S+)|(\S+\.\S+)):(\d+)(:(\d+))?]], 100, -1, { window = state.win })
end

local function create_buffer()
  state.buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, {})

  vim.api.nvim_set_option_value("modifiable", false, { buf = state.buf })
  vim.api.nvim_set_option_value("filetype", "compilation", { buf = state.buf })

  state.win = vim.api.nvim_open_win(state.buf, true, { split = 'below' })

  add_highlighting(state.buf)

  vim.api.nvim_create_autocmd({ "BufDelete", "WinClosed" }, {
    group = augroup,
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
    create_buffer()
  end

  temp_unlock_buf(state.buf, function(buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Compilation started at " .. os.date("%a %b %d %H:%M:%S"), "" })
  end)

  return state.buf
end

local function scroll_to_bottom()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    local last_line = vim.api.nvim_buf_line_count(state.buf)
    vim.api.nvim_win_set_cursor(state.win, { last_line, 0 })
  end
end

local function append_lines(buffer, lines)
  if not lines or #lines == 0 then return end

  if lines[#lines] == "" then
    table.remove(lines, #lines)
  end

  local start_line = vim.api.nvim_buf_line_count(buffer)

  temp_unlock_buf(state.buf, function(buf)
    vim.api.nvim_buf_set_lines(buf, start_line, start_line, false, lines)
  end)

  scroll_to_bottom()
end

local function run(cmd)
  local buffer = get_buffer()
  append_lines(buffer, { cmd })

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data, _)
      if data then
        append_lines(buffer, data)
      end
    end,

    on_stderr = function(_, data, _)
      if data then
        append_lines(buffer, data)
      end
    end,

    on_exit = function(_, exit_code, _)
      local str = (exit_code == 0)
          and "ended"
          or ("exited abnormally with code " .. exit_code)

      local line = "Compilation " .. str .. " at " .. os.date("%a %b %d %H:%M:%S")
      append_lines(buffer, { "", line })

      local last_line = vim.api.nvim_buf_line_count(buffer) - 1
      local match = (exit_code == 0) and "ended" or "exited abnormally"
      local s, e = line:find(match)

      if s and e then
        vim.api.nvim_buf_set_extmark(buffer, ns_id, last_line, s - 1, {
          end_col = e,
          hl_group = (exit_code == 0) and "CompilationFinish" or "CompilationError",
        })
      end

      if exit_code ~= 0 then
        local code_str = tostring(exit_code)
        local cs = line:find(code_str, e + 1, true)
        if cs then
          vim.api.nvim_buf_set_extmark(buffer, ns_id, last_line, cs - 1, {
            end_col = cs - 1 + #code_str,
            hl_group = "CompilationError",
          })
        end
      end
    end,
  })
end

vim.api.nvim_create_user_command('Compile', function(ctx)
  local cmd = ctx.args

  if cmd == "" then
    cmd = vim.fn.input({
      prompt = "Compile command: ",
      default = last_prompt,
      completion = 'shellcmdline',
      cancelreturn = ''
    })
    last_prompt = cmd

    if cmd == "" then
      vim.notify("No command provided.", vim.log.levels.WARN)
      return
    end
  end

  run(cmd)
end, { nargs = '*', complete = 'shellcmdline' })
