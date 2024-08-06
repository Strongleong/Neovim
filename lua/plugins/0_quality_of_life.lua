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
    dependencies = {
      "luarocks.nvim" ,
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

  {
    'LunarVim/bigfile.nvim',
    config = true
  },

  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },

  -- {
  --   "3rd/image.nvim",
  --   dependencies = { "luarocks.nvim" },
  --   config = {
  --     editor_only_render_when_focused = true,
  --   },
  -- },

  'RRethy/vim-illuminate',

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
}
