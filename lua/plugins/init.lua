return {
  'nvim-lua/popup.nvim',
  'famiu/bufdelete.nvim',
  'tpope/vim-sleuth',
  'tpope/vim-repeat',

  'vifm/vifm.vim',
  'fedepujol/move.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',

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
