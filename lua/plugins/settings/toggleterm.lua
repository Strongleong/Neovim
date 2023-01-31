local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then
  vim.notify('Error. Toggleterm is not installed')
  return
end

local is_windows = require'custom.lib'.is_windows

if is_windows then
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''

  vim.opt.shelltemp = false
end

toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<Leader>t]],
  on_open = function(t)
    if not is_windows then
      t:send('zsh_short_prompt')
    end
  end,
  terminal_mappings = true,
  close_on_exit     = true,
  direction         = 'vertical',
  shade_terminals   = false
})
