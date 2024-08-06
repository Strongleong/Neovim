return {
  'lewis6991/gitsigns.nvim',
  config = {
    signcolumn          = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl               = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl              = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff           = false, -- Toggle with `:Gitsigns toggle_word_diff`
    status_formatter    = nil,   -- Use default
    attach_to_untracked = true,
    sign_priority       = 6,
    update_debounce     = 100,
    max_file_length     = 40000,
    watch_gitdir = {
      interval     = 1000,
      follow_files = true,
    },
    preview_config = {
      -- Options passed to nvim_open_win
      border   = "single",
      style    = "minimal",
      relative = "cursor",
      row      = 0,
      col      = 1,
    },
  }
}
