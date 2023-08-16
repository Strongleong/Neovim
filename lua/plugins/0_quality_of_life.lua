return {
  "EdenEast/nightfox.nvim",

  'tpope/vim-sleuth',
  'tpope/vim-repeat',
  'famiu/bufdelete.nvim',
  'junegunn/vim-easy-align',
  'fedepujol/move.nvim',
  'lyokha/vim-xkbswitch',

  { 'norcalli/nvim-colorizer.lua',       config = true },
  { 'kylechui/nvim-surround',            config = true },
  { 'phaazon/hop.nvim',                  config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true },
  { 'j-hui/fidget.nvim',                 config = true, tag = 'legacy' },
  { 'kyazdani42/nvim-web-devicons',      lazy = true },

  {
    'alexghergh/nvim-tmux-navigation',
    config = { disable_when_zoomed = true }
  },
}
