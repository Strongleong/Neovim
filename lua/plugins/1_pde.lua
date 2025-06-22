return {
	{
		'williamboman/mason.nvim',
		dependencies = {
			'mhartington/formatter.nvim',
			'rshkarin/mason-nvim-lint',
		},
		config = true
	},

	{
		'folke/lazydev.nvim',
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
			{ "nvim-dap-ui" },
		},
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'saghen/blink.cmp',
			'folke/lazydev.nvim',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			"b0o/schemastore.nvim",
		},
		config = function()
			local mason  = require("mason-lspconfig")
			local lsp    = require("lspconfig")
			local blink  = require("blink.cmp")

			--- @type vim.diagnostic.Opts
			local config = {
				virtual_text     = true,
				update_in_insert = true,
				underline        = true,
				severity_sort    = true,
				float            = {
					focusable = false,
					style     = "minimal",
					border    = "single",
					source    = true,
				},
				signs            = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN]  = "",
						[vim.diagnostic.severity.INFO]  = "",
						[vim.diagnostic.severity.HINT]  = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
						[vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
						[vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
					}
				},
			}

			vim.diagnostic.config(config)

			local capabilities = blink.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			local servers = mason.get_installed_servers()

			local on_attach = function(_, _)
				-- keymaps.on_attach()
			end

			for _, server in pairs(servers) do
				local ok, settings = pcall(require, "lsp.servers." .. server)
				local srv_config = {
					on_attach = on_attach,
					capabilities = capabilities
				}

				if ok then
					srv_config = vim.tbl_deep_extend('force', srv_config, settings)
				end

				lsp[server].setup(srv_config)
			end
		end
	},

	{
		'saghen/blink.cmp',
		dependencies = {
			'rafamadriz/friendly-snippets',
			'L3MON4D3/LuaSnip',
			'folke/lazydev.nvim',
		},
		version = '1.*',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'default',
				['<CR>'] = { 'accept', 'fallback' },
				['<C-p>'] = { 'show', 'select_prev', 'fallback_to_mappings' },
				['<C-n>'] = { 'show', 'select_next', 'fallback_to_mappings' },
			},
			cmdline = {
				completion = {
					menu = {
						auto_show = function(_)
							return vim.fn.getcmdtype() == ':'
								or vim.fn.getcmdtype() == '/'
								or vim.fn.getcmdtype() == '?'
						end,
					},
					list = {
						selection = {
							preselect = false,
						}
					}
				},
				keymap = {
					preset = 'default',
					['<Tab>'] = { 'accept', 'fallback' },
				}
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = false,
				},
			},
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					treesitter_highlighting = false,
				},
				ghost_text = {
					enabled = true,
					show_with_menu = false,
				},
				menu = {
					auto_show = false,
					draw = {
						columns = {
							{ "kind_icon",  gap = 1 },
							{ "label",      "label_description", gap = 1 },
							{ "source_name" },
						},
						treesitter = { 'lsp' },
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local icon = ctx.kind_icon
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)

									if dev_icon then
										icon = dev_icon
									end

									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local hl = ctx.kind_hl

									if not vim.tbl_contains({ "Path" }, ctx.source_name) then
										return hl
									end

									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end

									return hl
								end,
							},
						},
					},
				},
			},
			snippets = { preset = 'luasnip' },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
				per_filetype = {
					lua = { inherit_defaults = true, 'lazydev' },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					cmdline = {
						min_keyword_length = function (ctx)
							if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
								return 3
							end

							return 0
						end
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	{
		'glepnir/lspsaga.nvim',
		event = "LspAttach",
		dependencies = {
			'kyazdani42/nvim-web-devicons',
			'nvim-treesitter/nvim-treesitter'
		},
		opts = {
			symbol_in_winbar = {
				enable = true
			},
			outline = {
				detail = false,
			}
		}
	},

	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio'
		},
		config = function()
			local dap, dapui = require('dap'), require("dapui")

			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end

			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.api.nvim_create_autocmd('Filetype', {
				pattern = 'dap-float',
				command = 'nnoremap q :q<CR>',
			})
		end
	},

	{
		dir = "~/projects/strongleong/nvim/compmode.nvim/",
		config = {
			scroll_to_the_bottom = true
		},
	}
}
