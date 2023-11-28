return {
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = false,
        config = function ()
            local tcc = require('ts_context_commentstring')
            tcc.setup()
        end
    },

    {
        'numToStr/Comment.nvim',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        lazy = false,
        config = function ()
            local comment = require("Comment")
            comment.setup {
                -- I left default keymaps here so I can find them without google
                toggler = {           -- LHS of toggle mappings in NORMAL mode
                    line  = 'gcc',    -- Line-comment toggle keymap
                    block = 'gbc',    -- Block-comment toggle keymap
                },
                opleader = {          -- LHS of operator-pending mappings in NORMAL and VISUAL mode
                    line  = 'gc',     -- Line-comment keymap
                    block = 'gb',     -- Block-comment keymap
                },
                extra = {             -- LHS of extra mappings
                    above = 'gcO',    -- Add comment on the line above
                    below = 'gco',    -- Add comment on the line below
                    eol   = 'gcA',    -- Add comment at the end of line
                },
                mappings = {          -- Enable keybindings. NOTE: If given `false` then the plugin won't create any mappings
                    basic    = true,  -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    extra    = true,  -- Extra mapping; `gco`, `gcO`, `gcA`
                    extended = false, -- Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
                },
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    },
}


