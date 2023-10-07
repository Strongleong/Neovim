return {
  'NeogitOrg/neogit',
  cmd = "Neogit",
  dependencies = {
    'tpope/vim-fugitive',
    'sindrets/diffview.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    commit_popup = {
      kind = "split",
    },
    kind = "tab",
    signs = {
      section = { ">", "v" },
      item = { ">", "v" },
      hunk = { ">", "v" },
    },
    integrations = {
      diffview = true,
    },
    sections = {
      untracked = {
        folded = false,
      },
      unstaged = {
        folded = false,
      },
      staged = {
        folded = false,
      },
      stashes = {
        folded = true,
      },
      unpulled = {
        folded = true,
        hidden = false,
      },
      unmerged = {
        folded = false,
        hidden = false,
      },
      recent = {
        folded = true,
      },
    },
    mappings = {
      ["B"] = "BranchPopup",
    },
  }
}
