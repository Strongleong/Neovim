return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },

  {
    'rcarriga/cmp-dap',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },
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
    }
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
    }
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      dap.listeners.before['event_breakpoint']['my-plugin'] = function(session, body)
        print('Session terminated', vim.inspect(session), vim.inspect(body))
      end
    end
  }

}
