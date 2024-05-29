return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'sindrets/diffview.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = {
      git_services = {
        ["git.sakh.com"] = "https://git.sakh.com/${owner}/${repository}/compare/${branch_name}",
      },
      integrations = {
        diffview = true,
        telescope = true,
      },
      commit_editor = {
        kind = 'split',
      },
      --[[ mappings = {
        status = {
          ["q"] = function ()
            if vim.g.neogit then
              vim.cmd(":qa!")
            end

            require'neogit'.close()
          end
        }
      }, ]]
    },
  },

  'lewis6991/gitsigns.nvim',
  'tpope/vim-fugitive',
}
