return {
  "EdenEast/nightfox.nvim",

  'tpope/vim-sleuth',
  'tpope/vim-repeat',
  'famiu/bufdelete.nvim',
  'junegunn/vim-easy-align',
  {
    'fedepujol/move.nvim',
    config = {
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
  -- 'lyokha/vim-xkbswitch',

  { 'norcalli/nvim-colorizer.lua',       config = true },
  { 'kylechui/nvim-surround',            config = true },
  { 'phaazon/hop.nvim',                  config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },
  { "johmsalas/text-case.nvim",          config = true },
  { 'j-hui/fidget.nvim',                 config = true },
  { 'kyazdani42/nvim-web-devicons',      lazy = true },

  {
    'mrjones2014/smart-splits.nvim',
    config = {
      disable_multiplexer_nav_when_zoomed = true,
    }
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "3rd/image.nvim",
    },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },

  {
    'gbprod/substitute.nvim',
    config = {
      range = {
        prefix = "cp"
      }
    }
  },

  -- {
  --   "3rd/image.nvim",
  --   config = {
  --     backend = "ueberzug"
  --   }
  -- }
}
