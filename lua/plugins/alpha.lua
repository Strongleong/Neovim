return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	dependencies = {
		'kyazdani42/nvim-web-devicons',
	},
	config = function()
		local alpha     = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local headers   = require("custom.alpha_headers")
		local make_cmd  = vim.api.nvim_create_user_command

		function RandomTitle()
			local header = headers.get_random(dashboard.section.header.val)
			SetHeader(header)
		end

		function Title(opts)
			local headerName = opts.args
			local header = headers.setHeader(headerName)
			SetHeader(header)
		end

		function TelescopeTitle()
			require 'custom.alpha_heards_picker'.select_header()
			pcall(vim.cmd.AlphaRedraw)
		end

		function SetHeader(header)
			dashboard.section.header.val     = header.header
			dashboard.section.header.opts.hl = header.colorscheme
			pcall(vim.cmd.AlphaRedraw)
		end

		make_cmd('AlphaRandomTitle',    RandomTitle,    { nargs = 0 })
		make_cmd('AlphaTelescopeTitle', TelescopeTitle, { nargs = 0 })
		make_cmd('AlphaTitle',          Title,          { nargs = 1, complete = headers.autocomplete })

		RandomTitle()

		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find file",           ":Telescope find_files <CR>"               ),
			dashboard.button("e", "󰈔  New file",            ":ene <BAR> startinsert <CR>"              ),
			dashboard.button("r", "󱇧  Recently used files", ":Telescope oldfiles <CR>"                 ),
			dashboard.button("a", "󰊄  Find text",           ":Telescope live_grep <CR>"                ),
			dashboard.button("c", "  Configuration",       ":cd ~/.config/nvim/ <BAR> e init.lua<CR>" ),
			dashboard.button("n", "  Random title",        ":AlphaRandomTitle<CR>"                    ),
			dashboard.button("t", "  Telescope title",     ":AlphaTelescopeTitle<CR>"                 ),
			dashboard.button("g", "  Neogit",              ":Neogit<CR>"                              ),
			dashboard.button("q", "󰅙  Quit Neovim",         ":qa<CR>"                                  ),
		}

		dashboard.section.buttons.opts.hl          = "Constant"
		dashboard.section.buttons.opts.hl_shortcut = "Constant"
		dashboard.section.footer.opts.hl           = "Comment"

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)

		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		alpha.setup(dashboard.opts)
	end
}
