return {
	{
		'williamboman/mason.nvim',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
		},
		config = true,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("null-ls").setup()
			require("mason-null-ls").setup({
				automatic_setup = true,
				handlers = {}
			})
		end,
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			"b0o/schemastore.nvim",
		},
		config = function()
			local masonlspconfig = require("mason-lspconfig")
			local lspconfig      = require("lspconfig")
			local cmp_nvim_lsp   = require("cmp_nvim_lsp")

			local config         = {
				virtual_text = true,
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "single",
					source = "always",
				},
			}

			vim.diagnostic.config(config)
			vim.cmd([[
				sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
				sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=
				sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=
				sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=
			]])

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "none",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "none",
			})

			local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local servers = masonlspconfig.get_installed_servers()

			local on_attach = function(client, bufnr)
				-- keymaps.on_attach()
			end

			for _, server in pairs(servers) do
				local ok, settings = pcall(require, "lsp.servers." .. server)
				local srv_config = {}

				if server == 'tsserver' or server == 'volar' then
					capabilities.textDocument.formatting = false
				end

				if not ok then
					srv_config = {
						on_attach = on_attach,
						capabilities = capabilities,
					}
				else
					srv_config = {
						on_attach = on_attach,
						capabilities = capabilities,
						settings = settings.settings,
						filetypes = settings.filetypes
					}
				end

				lspconfig[server].setup(srv_config)
			end
		end
	},

	{
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
	},

}