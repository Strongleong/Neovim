return {
  "EdenEast/nightfox.nvim",

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
}
