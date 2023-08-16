local ok, _ = pcall(require, 'telescope')
if not ok then
  vim.notify('Error. telescope is not installed')
  return
end

local headers = require 'custom.alpha_headers'

local conf         = require("telescope.config").values
local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local actions      = require("telescope.actions")
local previewers   = require("telescope.previewers")
local action_state = require("telescope.actions.state")

M = {}

M.select_header = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = "Select Header",

    finder = finders.new_table {
      results = headers.getHeadersNames()
    },

    sorter = conf.generic_sorter(opts),

    previewer = previewers.new_buffer_previewer({
      title = function(_)
        return "Headers"
      end,

      define_preview = function(self, entry, _)
        local header_name = entry[1]
        local bufnr = self.state.bufnr
        vim.api.nvim_buf_clear_namespace(bufnr, -1, 1, -1)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, headers.headers[header_name].header)
        for k, _ in pairs(headers.headers[header_name].header) do
          vim.api.nvim_buf_add_highlight(bufnr, -1, headers.headers[header_name].colorscheme, k - 1, 0, -1)
        end
      end
    }),

    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("AlphaTitle " .. selection[1])
      end)
      return true
    end
  }):find()
end

return M
