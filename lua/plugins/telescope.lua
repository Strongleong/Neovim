return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-dap.nvim',
	},
	config = function ()
		telescope =require("telescope")

		vim.api.nvim_set_hl(0, "TelescopeNormal",        {bg="none", fg="#C8D0E0"})
		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", {bg="none", fg="#C8D0E0"})
		vim.api.nvim_set_hl(0, "TelescopePromptNormal",  {bg="none", fg="#C8D0E0"})
		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {bg="none", fg="#C8D0E0"})

		vim.api.nvim_set_hl(0, "TelescopeBorder",        {bg="none", fg="#81A1C1"})
		vim.api.nvim_set_hl(0, "TelescopePromptBorder",  {bg="none", fg="#81A1C1"})
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {bg="none", fg="#81A1C1"})
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {bg="none", fg="#81A1C1"})

		telescope.setup {
			defaults = {
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
			}
		}

		telescope.load_extension('dap')
		-- telescope.load_extension('fzf')
	end
}
