return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'sindrets/diffview.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = {
      git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        ["git.sakh.com"] = "https://git.sakh.com/${owner}/${repository}/compare/${branch_name}",
      },
      integrations = {
        diffview = true,
        telescope = true,
      },
      commit_editor = {
        kind = 'split',
      },
    },
  },

  'sindrets/diffview.nvim',
  'lewis6991/gitsigns.nvim',
  'tpope/vim-fugitive',
}
