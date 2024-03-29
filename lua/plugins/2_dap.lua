return {
  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = true,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    }
  },

  {
    'LiadOz/nvim-dap-repl-highlights',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter'
    },
    config = true,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require('dap')
      local keymaps = require'keymaps'

      dap.listeners.after['event_initialized']['hoverer'] = function()
        for _, buf in pairs(vim.api.nvim_list_bufs()) do
          pcall(vim.api.nvim_buf_del_keymap, buf, 'n', 'K')
        end

        keymaps.mapHoverDap()
      end

      dap.listeners.after['event_terminated']['hoverer'] = function()
        for _, buf in pairs(vim.api.nvim_list_bufs()) do
          pcall(vim.api.nvim_buf_del_keymap, buf, 'n', 'K')
        end

        keymaps.mapHoverLsp()
      end

      dap.listeners.after['disconnect']['hoverer'] = function()
        for _, buf in pairs(vim.api.nvim_list_bufs()) do
          pcall(vim.api.nvim_buf_del_keymap, buf, 'n', 'K')
        end

        keymaps.mapHoverLsp()
      end

      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after['event_initialized']["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before['event_terminated']["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before['event_exited']["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before['disconnect']["dapui_config"] = function()
        dapui.close()
      end

      vim.api.nvim_create_autocmd('Filetype', {
        pattern = 'dap-float',
        command = 'nnoremap q :q<CR>',
      })

      pcall(require, 'daps')
      require('dap.ext.vscode').load_launchjs();
    end
  }
}
