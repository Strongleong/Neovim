return {
  'nvim-lua/popup.nvim',
  'famiu/bufdelete.nvim',
  'tpope/vim-sleuth',
  'tpope/vim-repeat',

  'vifm/vifm.vim',
  'fedepujol/move.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',


  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = true
  },
  {
    'phaazon/hop.nvim',
    config = true
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = true
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = true
  },
{
  'kylechui/nvim-surround',
  config = true
},
{
	'alexghergh/nvim-tmux-navigation',
	config = {
		disable_when_zoomed = true -- defaults to false
	}
},
  {
	'kyazdani42/nvim-web-devicons',
	lazy = true,
	config = {
		default = true
	}
},
{
  'nvim-telescope/telescope-fzf-native.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
},
{
	'junegunn/vim-easy-align',
	config = function ()
		vim.g.easy_align_delimiters = {
			p = {
				pattern = '/\\$/',
			}
		}
	end
},

	'lyokha/vim-xkbswitch',

  -- Colorchemes
  "EdenEast/nightfox.nvim",

  -- Debuging
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'rcarriga/cmp-dap',
  'nvim-telescope/telescope-dap.nvim',
  'theHamsta/nvim-dap-virtual-text',

  {
    'mbledkowski/neuleetcode.vim',
    config = function ()
      vim.g.leetcode_browser = 'firefox'
    end
  }
}
