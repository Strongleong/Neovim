return {
    -- 'hrsh7th/nvim-cmp',
    -- event = "InsertEnter",
    -- dependencies = {
    --     'hrsh7th/cmp-nvim-lsp',     -- Lsp completions
    --     'hrsh7th/cmp-buffer',       -- Buffer completions
    --     'hrsh7th/cmp-path',         -- Path completions
    --     'hrsh7th/cmp-cmdline',      -- Cmdline completions
    --     'hrsh7th/cmp-emoji',        -- Markdown emoji completions
    --     'saadparwaiz1/cmp_luasnip', -- Snippet completions
    --     'L3MON4D3/LuaSnip',         -- Snippets engine
    --     'rcarriga/cmp-dap',         -- Completions for DAP repl
    -- },
    -- config = function()
    --     local cmp = require("cmp")
    --     local luasnip = require("luasnip")
    --
    --     local function leave_snippet()
    --         if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
    --             and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
    --             and not luasnip.session.jump_active
    --         then
    --             luasnip.unlink_current()
    --         end
    --     end
    --
    --     vim.api.nvim_create_autocmd('ModeChanged', {
    --         pattern  = '*',
    --         callback = leave_snippet,
    --         desc     = 'Stop snippets when you leave to normal mode'
    --     })
    --
    --     local kind_icons = {
    --         Text          = "",
    --         Method        = "󰆧",
    --         Function      = "󰊕",
    --         Constructor   = "",
    --         Field         = "󰇽",
    --         Variable      = "󰂡",
    --         Class         = "󰠱",
    --         Interface     = "",
    --         Module        = "",
    --         Property      = "󰜢",
    --         Unit          = "",
    --         Value         = "󰎠",
    --         Enum          = "",
    --         Keyword       = "󰌋",
    --         Snippet       = "",
    --         Color         = "󰏘",
    --         File          = "󰈙",
    --         Reference     = "",
    --         Folder        = "󰉋",
    --         EnumMember    = "",
    --         Constant      = "󰏿",
    --         Struct        = "",
    --         Event         = "",
    --         Operator      = "󰆕",
    --         TypeParameter = "󰅲"
    --     }
    --
    --     cmp.setup({
    --         snippet = {
    --             expand = function(args)
    --                 luasnip.lsp_expand(args.body)
    --             end
    --         },
    --         view = {
    --             entries = { name = 'custom', selection_order = 'near_cursor' }
    --         },
    --         window = {
    --             -- completion    = cmp.config.window.bordered(),
    --             -- documentation = cmp.config.window.bordered()
    --         },
    --
    --         mapping = cmp.mapping.preset.insert({
    --             ['<C-b>']     = cmp.mapping.scroll_docs(-4),
    --             ['<C-f>']     = cmp.mapping.scroll_docs(4),
    --             ['<C-Space>'] = cmp.mapping.complete(),
    --             ['<C-e>']     = cmp.mapping.abort(),
    --             ['<CR>']      = cmp.mapping.confirm({ select = true }),
    --         }),
    --         formatting = {
    --             fields = { "kind", "abbr", "menu" },
    --             format = function(entry, vim_item)
    --                 -- Kind icons
    --                 vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --                 vim_item.menu = ({
    --                     nvim_lsp = "[LSP]",
    --                     luasnip  = "[Snippet]",
    --                     buffer   = "[Buffer]",
    --                     emoji    = "[Emoji]",
    --                     cmdline  = "[CmdLine]",
    --                 })[entry.source.name]
    --                 return vim_item
    --             end,
    --         },
    --         sources = cmp.config.sources({
    --             { name = "path" },
    --             -- { name = "dap" },
    --             { name = "nvim_lsp" },
    --             { name = "luasnip" },
    --             { name = "buffer" },
    --             { name = "emoji" },
    --         }),
    --         confirm_opts = {
    --             behavior = cmp.ConfirmBehavior.Replace,
    --             select = false,
    --         },
    --         experimental = {
    --             ghost_text = true,
    --             native_menu = false,
    --         },
    --         confirmation = {
    --             get_commit_characters = function(_)
    --                 return {}
    --             end
    --         },
    --
    --         enabled = function()
    --             return vim.api.nvim_get_option_value("buftype", { buf = 0}) ~= "prompt"
    --                 or require("cmp_dap").is_dap_buffer()
    --         end
    --     })
    --
    --     cmp.setup.cmdline(':', {
    --         sources = {
    --             { name = "path" },
    --             { name = 'cmdline' }
    --         }
    --     })
    --
    --     cmp.setup.cmdline('/', {
    --         sources = {
    --             { name = 'buffer' }
    --         },
    --     })
    --
    --     cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    --         sources = {
    --             { name = "dap" },
    --         },
    --     })
    -- end
}
