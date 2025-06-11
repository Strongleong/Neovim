local function create_autocmd(definitions)
  for group_name, autocmds in pairs(definitions) do
    local augroup = vim.api.nvim_create_augroup(group_name, {});
    for _, autocmd in pairs(autocmds) do
      autocmd.opts.group = augroup
      vim.api.nvim_create_autocmd(autocmd.events, autocmd.opts)
    end
  end
end

local autoCommands = {
  NewFiletypes = {
    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { 'Gemfile', 'Rakefile', 'Vagrantfile', 'Thorfile', 'config.ru' },
        command = 'set ft=ruby',
        desc    = 'Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby'
      },
    },
    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.twig', '*.twig' },
        command = 'set ft=htmljinja',
        desc    = 'Map .twig files as jinja templates'
      },
    },
    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = '*.coffee',
        command = 'set ft=coffee',
        desc    = 'Map *.coffee to coffee type'
      },
    },
    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = '*.es6',
        command = 'set ft=javascript',
        desc    = 'Highlight es6 like Javascript'
      },
    },
    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.mustache', '*.hbs' },
        command = 'set ft=mustache',
        desc    = 'Hbs and mustache files.'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = 'Jenkinsfile',
        command = 'set ft=groovy',
        desc    = 'Jenkinsfile are groovy'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.lr' },
        command = 'set ft=eventsdown',
        desc    = 'Lector uses custom file types, but eventsdown contents.'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.rasi' },
        command = 'set ft=rasi',
        desc    = 'Rasi file type (rofi config)'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.qml' },
        command = 'set ft=qml',
        desc    = 'QML file type (SDDM theme scripting)'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*env.example' },
        command = 'set ft=sh',
        desc    = 'env.example files == .env files'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.h' },
        command = 'set ft=c',
        desc    = 'set .h file to c in instead of cpp (for cpp use .hpp instead)'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.porth' },
        command = 'set ft=porth',
        desc    = 'Add support for porth'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.ASM' },
        command = 'set ft=asm',
        desc    = 'Uppercase asm are pepole too'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { 'env', 'env.example' },
        command = 'set ft=sh',
        desc    = '.env files are not always starts with dot. Sometimes.'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { 'php.example' },
        command = 'set ft=php',
        desc    = 'Example files for some configis for PHP projects'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.php.example' },
        command = 'set ft=php',
        desc    = 'php.example files are .php files anyways'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.c3' },
        command = 'set ft=c3',
        desc    = 'File type detection for c3 language'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { 'LICENSE' },
        command = 'set ft=license',
        desc    = 'Set correct filetype for license files'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*/hypr/*.conf' },
        command = 'set ft=hyprlang',
        desc    = 'Set correct filetype for license files'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.MD' },
        command = 'set ft=markdown',
        desc    = 'Sometimes people create markdown files with capslock enabled I guess'
      },
    },

    {
      events = { 'BufNewFile', 'BufRead' },
      opts   = {
        pattern = { '*.yml' },
        command = 'set ft=xml',
        desc    = 'Yandex markup language is litterally XML'
      },
    },
  },

  Filetypes = {
    {
      events = 'FileType',
      opts   = {
        pattern = 'python',
        command = 'setl softtabstop=4 shiftwidth=4 tabstop=4 textwidth=100',
        desc    = 'Make python follow PEP8'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = 'rst',
        command = 'setl textwidth=80',
        desc    = 'Make python follow PEP8'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = { 'cucumber', 'yaml', 'sass', 'scss', 'ruby', 'eruby', 'less' },
        command = 'setl softtabstop=2 shiftwidth=2 tabstop=2',
        desc    = 'Make ruby,scss,sass,less use 2 spaces for indentation.',
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = 'php',
        command = 'setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4',
        desc    = 'PHP settings'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = 'go',
        command = 'setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 noexpandtab',
        desc    = 'Golang settings'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = 'eventsdown',
        command = 'setl textwidth=80 softtabstop=4 shiftwidth=4 tabstop=4',
        desc    = 'eventsdown settings'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = { 'css', 'typescript', 'javascript', 'mustache', 'htmljinja', 'html' },
        command = 'setl textwidth=100 softtabstop=2 shiftwidth=2 tabstop=2',
        desc    = 'Javascript, CSS, and html settings'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = { 'pov' },
        command = 'set filetype=php',
        desc    = 'Inc files are php'
      },
    },

    {
      events = 'FileType',
      opts   = {
        pattern = { 'coffee', 'groovy', 'elm', 'dockerfile' },
        command = 'setl textwidth=100 softtabstop=2 shiftwidth=2 tabstop=2',
        desc    = 'CoffeeScript, Groovy, Elm, Docker'
      },
    },
  },

  TrimSpaces = {
    {
      events = 'BufWritePre',
      opts = {
        pattern = '*',
        command = [[:%s/\s\+$//e]],
        desc = "Automatically strip trailing spaces on save"
      }
    }
  },

  NvimTree = {
    {
      events = 'QuitPre',
      opts = {
        desc = 'Automatically close nvim-tree if it is last window',
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= '' then
              table.insert(floating_wins, w)
            end
          end
          if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      }
    }
  },

  Alpha = {
    {
      events = "User",
      opts = {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local message = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          require("alpha.themes.dashboard").section.footer.val = message
          pcall(vim.cmd.AlphaRedraw)
        end,
      }
    }
  },

  Terminal = {
    {
      events = "TermOpen",
      opts = {
        command = 'setlocal nonumber norelativenumber',
        desc    = 'Disable line numbers in terminal'
      }
    }
  },
}

create_autocmd(autoCommands)
