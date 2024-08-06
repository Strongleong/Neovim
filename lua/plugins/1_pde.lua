return {
	{
		'williamboman/mason.nvim',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'mfussenegger/nvim-lint',
			'mhartington/formatter.nvim',
			'rshkarin/mason-nvim-lint',
		},
		config = function ()
			require'mason'.setup()
			require('lint').linters_by_ft = {
				markdown = {'vale'},
				php = {'phpcs'},
				dockerfile = {'hadolint'},
				json = {'jsonlint'},
			}
			require'mason-nvim-lint'.setup()
			require'formatter'.setup({
				filetype = {
					php = {
						require('formatter.filetypes.php').phpcbf
					}
				}
			})
		end,
	},

	{ 'folke/neodev.nvim', setup = true },

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'folke/neodev.nvim',
			'hrsh7th/cmp-nvim-lsp',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			"b0o/schemastore.nvim",
		},
		config = function()
			local masonlspconfig = require("mason-lspconfig")
			local lspconfig      = require("lspconfig")
			local cmp_nvim_lsp   = require("cmp_nvim_lsp")
			local lib            = require("custom.lib")

			local config = {
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
				if server == 'rust_analyzer' then
					goto continue
				end

				local ok, settings = pcall(require, "lsp.servers." .. server)
				local srv_config = {
					on_attach = on_attach,
					capabilities = capabilities
				}

				if ok then
					lib.tableMerge(srv_config, settings)
				end

				lspconfig[server].setup(srv_config)
				::continue::
			end

			local conf = lib.tableMerge(require("lsp.servers.omnisharp"), {
				on_attach = on_attach,
				capabilities = capabilities
			})
			lspconfig.omnisharp.setup(conf)
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
			},
			outline = {
				detail = false,
			}
		}
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			"Issafalcon/neotest-dotnet",
			"olimorris/neotest-phpunit",
		},

		config = function()
			require 'neotest'.setup({
				adapters = {
					require 'neotest-phpunit',
					require 'neotest-dotnet'({
						discovery_root = "solution"
					}),
				}
			})
		end
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
	},

	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		ft = { 'rust' },
		config = function ()
			vim.g.rustaceanvim = {
				server = {
				}
			}
		end
	}
}
