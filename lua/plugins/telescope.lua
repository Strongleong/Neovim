return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-dap.nvim',
            { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
        },
        config = function()
            local telescope = require("telescope")
            local tactions = require("telescope.actions")
            local lga_actions = require("telescope-live-grep-args.actions")

            vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none", fg = "#C8D0E0" })
            vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none", fg = "#C8D0E0" })
            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none", fg = "#C8D0E0" })
            vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none", fg = "#C8D0E0" })

            vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = "#81A1C1" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none", fg = "#81A1C1" })
            vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none", fg = "#81A1C1" })
            vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none", fg = "#81A1C1" })

            telescope.setup {
                defaults = {
                    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            i = {
                                ['<c-d>'] = tactions.delete_buffer,
                            },
                            n = {
                                ['<c-d>'] = tactions.delete_buffer,
                            },
                        }
                    },
                },
                extensions = {
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            },
                        }
                    }
                }
            }

            telescope.load_extension('fzf')
            telescope.load_extension('live_grep_args');
            telescope.load_extension('dap');

            require('keymaps').setup_telescope_keymaps()
        end
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
}
