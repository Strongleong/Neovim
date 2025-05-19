local colorscheme = 'nightfox'

require('general')
require('lazy-init')
require('keymaps')
require('autocommands')
require('colorschemes')(colorscheme)
require('custom.compile_mod')
