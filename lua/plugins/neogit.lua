return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = {
      graph_style = "unicode",
      git_services = {
        ["git.sakh.com"] = "https://git.sakh.com/${owner}/${repository}/compare/${branch_name}",
      },
      integrations = {
        diffview = true,
        telescope = true,
      },
      commit_editor = {
        kind = 'split',
        staged_diff_split_kind = "auto"
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
