return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  config = {
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
        },
        lualine_c = {
          {
            "buffers",
            symbols = {
              modified = ' ●',
              alternate_file = '',
              directory = '',
            },
          },

        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "diagnostics" },
        lualine_z = { "progress", "location" },
      },
      tabline = {},
      extensions = {
        "nvim-tree",
        "fzf",
        "lazy",
        "man",
        "mason",
        "nvim-dap-ui",
        "trouble",
        "quickfix"
      },
    }
}
