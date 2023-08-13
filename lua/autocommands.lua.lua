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
  Filetypes = {
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
        desc    = 'Uppercase asm is pepole too'
      },
    },

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
        command = 'set filetype=html',
        desc    = 'Inc files are html'
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
  OpenFolds = {
    {
      events = { "BufReadPost,FileReadPost" },
      opts = {
        pattern = "*",
        command = "normal zR",
        desc = "Unfold all TreeSitter folds"
      }
    }
  }
}

create_autocmd(autoCommands)
