return {
  {
    "EdenEast/nightfox.nvim",
    opts = function()
      local nightfox = require("nightfox")
      local cache_dir = vim.fn.stdpath("cache") .. "/nightfox"

      if vim.g.neovide then
        cache_dir = cache_dir .. "/gui"
      else
        cache_dir = cache_dir .. "/cli"
      end

      nightfox.setup({
        options = {
          compile_path = cache_dir,          -- Compiled file's destination location
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = not vim.g.neovide,   -- Disable setting background
          terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,              -- Non focused panes set to alternative background
          styles = {                         -- Style to be applied to different syntax groups
            comments     = "italic",         -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants    = "bold",
            functions    = "NONE",
            keywords     = "bold",
            numbers      = "NONE",
            operators    = "NONE",
            strings      = "NONE",
            types        = "italic,bold",
            variables    = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = {},
        },
        palettes = {},
        specs = {},
        groups = {
          all = {
            IlluminatedWordText = { gui = "underline", cterm = "underline" },
            IlluminatedWordRead = { gui = "underline", cterm = "underline" },
            IlluminatedWordWrite = { gui = "underline", cterm = "underline" },
          }
        },
      })

      -- setup must be called before loading
      vim.cmd("colorscheme nightfox")

      vim.cmd([[
        hi IlluminatedWordText gui=underline cterm=underline
        hi IlluminatedWordRead gui=underline cterm=underline
        hi IlluminatedWordWrite gui=underline cterm=underline
      ]])
    end
  },

  'tpope/vim-sleuth',
  'tpope/vim-repeat',
  'famiu/bufdelete.nvim',
  'junegunn/vim-easy-align',

  {
    'fedepujol/move.nvim',
    opts = {
      line = {
        enable = true, -- Enables line movement
        indent = true  -- Toggles indentation
      },
      block = {
        enable = true, -- Enables block movement
        indent = true  -- Toggles indentation
      },
      word = {
        enable = true, -- Enables word movement
      },
      char = {
        enable = true -- Enables char movement
      }
    }
  },

  { 'norcalli/nvim-colorizer.lua',       opts = {} },
  { 'kylechui/nvim-surround',            opts = {} },
  { 'phaazon/hop.nvim',                  opts = {} },
  { 'williamboman/mason-lspconfig.nvim', opts = {} },
  { "johmsalas/text-case.nvim",          opts = {} },
  { 'j-hui/fidget.nvim',                 opts = {} },
  { 'kyazdani42/nvim-web-devicons',      lazy = true },

  {
    'mrjones2014/smart-splits.nvim',
    opts = {
      disable_multiplexer_nav_when_zoomed = true,
    }
  },

  {
    'gbprod/substitute.nvim',
    opts = {
      range = {
        prefix = "cp"
      }
    }
  },

  {
    'LunarVim/bigfile.nvim',
    opts = {}
  },

  'RRethy/vim-illuminate',

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "IogaMaster/neocord",
    opts = {
      debounce_timeout = 2,
    }
  },

  {
    'ten3roberts/qf.nvim',
    opts = true
  },
}
