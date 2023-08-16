return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  config = {
    on_attach = require('keymaps').nvim_tree,
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        glyphs = {
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "★",
            ignored = "◌",
          },
        }
      }
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
  }
}
