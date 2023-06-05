return {
	'glepnir/lspsaga.nvim',
	event = "LspAttach",
	dependencies = {
		'kyazdani42/nvim-web-devicons',
		'nvim-treesitter/nvim-treesitter'
	},
	config = {
		symbol_in_winbar = {
			enable = true
		}
	}
}
