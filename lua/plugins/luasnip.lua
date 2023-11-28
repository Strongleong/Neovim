return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'mattn/emmet-vim',
    'rafamadriz/friendly-snippets',
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local luasnip = require('luasnip')
    local cmp = require("cmp")

    local t = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local check_back_space = function()
      local col = vim.fn.col('.') - 1
      if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
      else
        return false
      end
    end

    _G.tab_complete = function()
      if cmp and cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
      elseif check_back_space() then
        return t "<Tab>"
      else
        cmp.complete()
      end
      return ""
    end

    _G.s_tab_complete = function()
      if cmp and cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
      else
        return t "<S-Tab>"
      end
      return ""
    end

    vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
    vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
    vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

    luasnip.config.set_config({
      enable_autosnippets = true,
      update_events = 'TextChanged,TextChangedI'
    })

    -- TODO: lua-snippets.Make `snippets.lua` and dump every snippet there.
    --       Don't bother with `snippets/a.lua`
    require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip/loaders/from_lua").lazy_load({ paths = { "./lua/snippets" } })
  end
}
