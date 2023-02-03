return {
  'akinsho/toggleterm.nvim',
  config = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<Leader>t]],
    on_open = function(t)
      if not require'custom.lib'.is_windows then
        t:send('zsh_short_prompt')
      end
    end,
    terminal_mappings = true,
    close_on_exit     = true,
    direction         = 'vertical',
    shade_terminals   = false
  }
}
