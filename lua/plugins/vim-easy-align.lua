return {
	'junegunn/vim-easy-align',
	config = function ()
		vim.g.easy_align_delimiters = {
			p = {
				pattern = '/\\$/',
			}
		}
	end
}
