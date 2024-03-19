vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

vim.g.mapleader        = ' '
vim.opt.hidden         = true                         -- Allow files to remain open without saving
vim.opt.number         = true                         -- Line numbers
vim.opt.autoindent     = true                         -- Auto indenting
vim.opt.relativenumber = true                         -- Line numbers count away from current position
vim.opt.tabstop        = 2                            -- Tab width
vim.opt.softtabstop    = 2                            -- Soft tab width
vim.opt.shiftwidth     = 2                            -- Shift width
vim.opt.expandtab      = true                         -- Use spaces instead of tabs
vim.opt.path           = vim.opt.path + '**'          -- Searches current directory recursively.
vim.opt.clipboard      = 'unnamedplus'                -- Copy/paste between vim and other programs
vim.opt.undofile       = true                         -- Allow do undo even after restart
vim.opt.cursorline     = true                         -- Hilight line cursor on
vim.opt.foldmethod     = 'expr'                       -- Set foldlding method to 'expression'
vim.opt.foldlevelstart = 99                           -- Make that folds don't fold on startup
vim.opt.foldlevel      = 99                           -- Make that folds don't fold on startup
vim.opt.foldenable     = false                        -- Disable folding at startup for TreeSitter
vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()' -- Enable Treesitter folding
vim.opt.termguicolors  = true                         -- Pretty colors
vim.opt.backup         = false                        -- Creates a backup file
vim.opt.cmdheight      = 1                            -- No more space in the neovim command line for displaying messages
vim.opt.completeopt    = {'menuone', 'noselect'}      -- Mostly just for cmp
vim.opt.conceallevel   = 0                            -- So that `` is visible in markdown files
vim.opt.fileencoding   = 'utf-8'                      -- the encoding written to a file
vim.opt.hlsearch       = true                         -- Highlight all matches on previous search pattern
vim.opt.ignorecase     = true                         -- Ignore case in search patterns
vim.opt.mouse          = 'a'                          -- Allow the mouse to be used in neovim
vim.opt.pumheight      = 10                           -- Pop up menu height
vim.opt.showmode       = false                        -- We don't need to see things like -- INSERT -- Anymore
vim.opt.showtabline    = 1                            -- Show tabs
vim.opt.smartcase      = true                         -- Smart case
vim.opt.smartindent    = true                         -- Make indenting smarter again
vim.opt.splitbelow     = true                         -- Force all horizontal splits to go below current window
vim.opt.splitright     = true                         -- Force all vertical splits to go to the right of current window
vim.opt.swapfile       = false                        -- Creates a swapfile
vim.opt.timeoutlen     = 400                          -- Time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime     = 300                          -- Faster completion (4000ms default)
vim.opt.writebackup    = false                        -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.numberwidth    = 2                            -- Set number column width to 2 {default 4}
vim.opt.signcolumn     = 'yes'                        -- Always show the sign column, otherwise it would shift the text each time
vim.opt.wrap           = false                        -- Display lines as one long line
vim.opt.scrolloff      = 8                            -- Do not wait cursor at bottom to scroll
vim.opt.sidescrolloff  = 8                            -- Same as previous but horizontaly
vim.opt.guifont        = 'UbuntuMono Nerd Font:h11'   -- The font used in graphical neovim (gnvim/neovide/etc.) applications

-- I like when my home folder is clean. XDG rules!
local homePath    = os.getenv('HOME')
if homePath ~= nil then
  vim.opt.undodir   = homePath .. '/.local/nvim/undo'
  vim.opt.shadafile = homePath .. '/.local/nvim/shadafile'
end

local is_windows = require'custom.lib'.is_windows

-- Fix shell for `:term` command in Windows
if is_windows then
  vim.opt.shell        = 'pwsh'
  vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  vim.opt.shellredir   = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe    = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote   = ''
  vim.opt.shellxquote  = ''
  vim.opt.shelltemp    = false
end

-- If background is 0 neovide will draw background trasparent without any colors
if vim.g.neovide then
  vim.g.neovide_transparency = 0.8
else
  vim.g.background = 0;
end

-- Tmux colors fix
vim.cmd('let &t_8f = "\\<Esc>[38:2:%lu:%lu:%lum"')
vim.cmd('let &t_8b = "\\<Esc>[48:2:%lu:%lu:%lum"')


-------------------------- Vim plugins settings --------------------------
-- They are here because plugins spec looks less bloated this way and they
-- do not break neovim configuration if these plugins are not installed.

-- nvim-ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true

-- VimEasyAlign
vim.g.easy_align_delimiters = {
  p = { pattern = '/\\$/', }
}

-- Register excommand that opens Neogit from the current file
-- The command takes one argument which is passed to Neogit
vim.api.nvim_create_user_command(
  'NeogitRel', -- Name of the command
  function(opts)
    -- Call the local function with the argument
    require'custom.lib'.open_neogit_from_current_file(opts.args[1])
  end,
  { nargs = '?' } -- Specifies that the command takes one argument
)
