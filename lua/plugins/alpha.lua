return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	dependencies = {
		'kyazdani42/nvim-web-devicons',
	},
	config = function()
		local alpha     = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- vim.cmd([[:command! -nargs=0 AlphaRandomTitle lua RandomTitle()]])
		-- vim.cmd([[:command! -nargs=1 AlphaTitle lua SetHeader(args)]])

		function RandomTitle()
			local header = require "custom.alpha_headers".get_random(dashboard.section.header.val)
			SetHeader(header)
		end

		function Title(opts)
			local headerName = opts.args
			local header = require "custom.alpha_headers".setHeader(headerName)
			SetHeader(header)
		end

		function SetHeader(header)
			dashboard.section.header.val     = header.header
			dashboard.section.header.opts.hl = header.colorscheme
		end

		vim.api.nvim_create_user_command('AlphaRandomTitle', RandomTitle, { nargs = 0 })
		vim.api.nvim_create_user_command('AlphaTitle', Title, { nargs = 1 })

		RandomTitle()

		dashboard.section.buttons.val              = {
			dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
			dashboard.button("a", "  Find text", ":Telescope live_grep <CR>"),
			dashboard.button("c", "  Configuration", ":tabnew ~/.config/nvim/<CR>"),
			dashboard.button("n", "  Random title", ":AlphaRandomTitle<CR>:AlphaRedraw<CR>"),
			dashboard.button("g", "  Neogit", ":Neogit<CR>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
		}

		dashboard.section.buttons.opts.hl          = "Constant"
		dashboard.section.buttons.opts.hl_shortcut = "Constant"
		dashboard.section.footer.opts.hl           = "Comment"

		dashboard.opts.opts.noautocmd              = true
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

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end
}
