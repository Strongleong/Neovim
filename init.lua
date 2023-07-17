local colorscheme = 'nightfox'

require('general')
require('filetypes')
require('lazy-init')
require('keymaps')
require('colorschemes')(colorscheme)
--
-- vim.cmd([[
--   let $HOME=$USERPROFILE
-- ]])
