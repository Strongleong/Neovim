local function map(mode, keys, command, description, additional)
  local options = { silent = true }

  if description ~= nil then
    options.desc = description
  end

  if additional ~= nil then
    for k,v in pairs(additional) do options[k] = v end
  end

  vim.keymap.set(mode, keys, command, options)
end

local function mapa(keys, command, description, additional)
  map('', keys, command, description, additional)
end

local function mapn(keys, command, description, additional)
  map('n', keys, command, description, additional)
end

local function mapi(keys, command, description, additional)
  map('i', keys, command, description, additional)
end

local function mapv(keys, command, description, additional)
  map('v', keys, command, description, additional)
end

local function adjust_font_size(amount)
  local font_full = vim.api.nvim_get_option('guifont')
  local font, size = string.match(font_full, "(.*):h(.*)")
  size = size + amount
  vim.opt.guifont = font .. ":h" .. size
end

local function increment_font_size()
  adjust_font_size(1)
end

local function decrement_font_size()
  adjust_font_size(-1)
end

mapn('<Tab>',      ':bnext<CR>',                  '[Buffer] Next buffer')
mapn('<S-Tab>',    ':bprevious<CR>',              '[Buffer] Previous buffer')

mapn('<Leader>ve', ':tabnew ~/.config/nvim/<CR>', '[Config] Quick edit of config')

mapn('<C-Left>',   ':vertical resize +3<CR>',     '[Resize] Increase pane height')
mapn('<C-Right>',  ':vertical resize -3<CR>',     '[Resize] Decrease pane height')
mapn('<C-Up>',     ':resize +3<CR>',              '[Resize] Increase pane width')
mapn('<C-Down>',   ':resize -3<CR>',              '[Resize] Decrease pane width')

mapv('>',          '>gv',                         '[Indent] Indent in visual mode vithout leaving to normal mode')
mapv('<',          '<gv',                         '[Indent] Unindent in visual mode vithout leaving to normal mode')

mapn('-',          decrement_font_size,           '[GUI] Increase font size')
mapn('+',          increment_font_size,           '[GUI] Decrease font size')
mapi('<C-->',      decrement_font_size,           '[GUI] Increase font size')
mapi('<C-+>',      increment_font_size,           '[GUI] Decrease font size')




-- Snitch
--
-- local ok, snitch = pcall(require, "custom.snitch")
-- if ok then
--   mapn('<leader>s', snitch, '[Snitch] Get all TODO\'s')
-- end


local status_ok, tmux = pcall(require, "nvim-tmux-navigation")
if status_ok then
  mapn('<C-h>',     tmux.NvimTmuxNavigateLeft,       '[Navigation] Move focus left' )
  mapn('<C-j>',     tmux.NvimTmuxNavigateDown,       '[Navigation] Move focus down' )
  mapn('<C-k>',     tmux.NvimTmuxNavigateUp,         '[Navigation] Move focus up' )
  mapn('<C-l>',     tmux.NvimTmuxNavigateRight,      '[Navigation] Move focus Right' )
  mapn('<C-\\>',    tmux.NvimTmuxNavigateLastActive, '[Navigation] Move focus last active' )
  mapn('<C-Space>', tmux.NvimTmuxNavigateNext,       '[Navigation] Move focus next' )
else
  vim.notify('Error. nvim-tmux-navigation is not installed')
end

mapn('<A-j>', ':MoveLine(1)<CR>',    '[Move] Move line down')
mapn('<A-k>', ':MoveLine(-1)<CR>',   '[Move] Move line up')
mapn('<A-l>', ':MoveHChar(1)<CR>',   '[Move] Move char right')
mapn('<A-h>', ':MoveHChar(-1)<CR>',  '[Move] Move char left')
mapv('<A-j>', ':MoveBlock(1)<CR>',   '[Move] Move block down')
mapv('<A-k>', ':MoveBlock(-1)<CR>',  '[Move] Move block up')
mapv('<A-l>', ':MoveHBlock(1)<CR>',  '[Move] Move block right')
mapv('<A-h>', ':MoveHBlock(-1)<CR>', '[Move] Move block left')

map(  'n', '<leader>g', ':Neogit<CR>',                 '[Neogit] Open Neogit')
-- map(  'n', 'tl',        ':TagbarToggle<CR>',           '[Tagbar] Toggle Tagbar')
-- map(  'n', 'mm',        ':MinimapToggle<CR>',          '[Minimap] Toggle Minimap')
map(  'n', '<C-n>',     ':NvimTreeFindFileToggle<CR>', '[NvimTree] Toggle NvimTree')

status_ok, _ = pcall(require, 'telescope')
if status_ok then
  mapn('<leader>ff',      '<cmd>lua require("telescope.builtin").find_files()<cr>', '[Telescope] Find files')
  mapn('<leader>fg',      '<cmd>lua require("telescope.builtin").git_files()<cr>',  '[Telescope] Find git files')
  mapn('<leader>fa',      '<cmd>lua require("telescope.builtin").live_grep()<cr>',  '[Telescope] Find string')
  mapn('<leader>fb',      '<cmd>lua require("telescope.builtin").buffers()<cr>',    '[Telescope] Find buffer')
  mapn('<leader>fh',      '<cmd>lua require("telescope.builtin").help_tags()<cr>',  '[Telescope] Find help')
  mapn('<leader>fr',      '<cmd>lua require("telescope.builtin").oldfiles()<cr>',   '[Telescope] Find recent')
else
  vim.notify('Error. Telescope not found')
end

mapn('<space>q',   vim.diagnostic.setloclist,                 '[LSP] Send diagnostics to loclist')
mapn('<space>e',   vim.diagnostic.open_float,                 '[LSP] Open floating window with diagnostic')

mapn('<space>gh', '<cmd>Lspsaga lsp_finder<CR>',              '[LSP] Open finder')
mapn('[d',        '<cmd>Lspsaga diagnostic_jump_prev<CR>',    '[LSP] Goto previous diagnostic')
mapn(']d',        '<cmd>Lspsaga diagnostic_jump_next<CR>',    '[LSP] Goto next diagnostic')

-- Only jump to error

mapn("[D", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end,     '[LSP] Jump to previous error')
mapn("]D", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end,     '[LSP] Jump to next error')

mapn('<space>o',  '<cmd>Lspsaga outline<CR>',         '[LSP] Open outline'            )
mapn('K',         '<cmd>Lspsaga hover_doc<CR>',       '[LSP] Open hover window'       )
mapn('gp',        '<cmd>Lspsaga peek_definition<CR>', '[LSP] Peek definition'         )
mapn('<space>rn', '<cmd>Lspsaga rename<CR>"',         '[LSP] Rename selected element' )
mapn('<space>ca', '<cmd>Lspsaga code_action<CR>',     '[LSP] Open code action pop-up' )

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function (ev)
    local opts = { buffer = ev.buf }
    mapn('gd',           vim.lsp.buf.definition,                                 '[LSP] Go to definition',        opts)
    mapn('gD',           vim.lsp.buf.declaration,                                '[LSP] Go to declaration',       opts)
    mapn('gi',           vim.lsp.buf.implementation,                             '[LSP] Go to implementation',    opts)
    mapn('gr',           vim.lsp.buf.references,                                 '[LSP] Find all references',     opts)
    mapn('<space><C-k>', vim.lsp.buf.signature_help,                             '[LSP] Signature help',          opts)
    mapn('<space>wa',    vim.lsp.buf.add_workspace_folder,                       '[LSP] Add workspace folder',    opts)
    mapn('<space>wr',    vim.lsp.buf.remove_workspace_folder,                    '[LSP] Remove workspace folder', opts)
    mapn('<space>D',     vim.lsp.buf.type_definition,                            '[LSP] Open type definition',    opts)

    mapn('<space>wl',    function () print(vim.inspect(vim.lsp.buf.list_workspace_folders)) end, '[LSP] List workspace folders',  opts)
    mapn('<space>f',     function () require'custom.lsp-stuff'.lsp_formatting(ev.buf) end,       '[LSP] Format buffer',           opts)
  end,
})

mapn('t<C-n>', ':TestNearest<CR>', '[VimTest] Test nearset case')
mapn('t<C-f>', ':TestFile<CR>',    '[VimTest] Test file')
mapn('t<C-l>', ':TestLast<CR>',    '[VimTest] Test last case')
mapn('t<C-a>', ':TestSuite<CR>',   '[VimTest] Test suite')
mapn('t<C-v>', ':TestVisit<CR>',   '[VimTest] Test case under cursor')

mapn('<leader>lo', '<cmd>lua require"qf".open("l")<CR>',        '[QuicFix] Open location list')
mapn('<leader>lc', '<cmd>lua require"qf".close("l")<CR>',       '[QuicFix] Close location list')
mapn('<leader>ll', '<cmd>lua require"qf".toggle("l",true)<CR>', '[QuicFix] Toggle location list and stay in current window')
mapn('<leader>co', '<cmd>lua require"qf".open("c")<CR>',        '[QuicFix] Open quickfix list')
mapn('<leader>cc', '<cmd>lua require"qf".close("c")<CR>',       '[QuicFix] Close quickfix list')
mapn('<leader>cl', '<cmd>lua require"qf".toggle("c",true)<CR>', '[QuicFix] Toggle quickfix list and stay in current window')
mapn('<leader>j',  '<cmd>lua require"qf".below("l")<CR>',       '[QuicFix] Go to next location list entry from cursor')
mapn('<leader>k',  '<cmd>lua require"qf".above("l")<CR>',       '[QuicFix] Go to previous location list entry from cursor')
mapn('<leader>J',  '<cmd>lua require"qf".below("c")<CR>',       '[QuicFix] Go to next quickfix entry from cursor')
mapn('<leader>K',  '<cmd>lua require"qf".above("c")<CR>',       '[QuicFix] Go to previous quickfix entry from cursor')
mapn(']q',         '<cmd>lua require"qf".below("visible")<CR>', '[QuicFix] Go to next entry from cursor in visible list')
mapn('[q',         '<cmd>lua require"qf".above("visible")<CR>', '[QuicFix] Go to previous entry from cursor in visible list')

local dap
status_ok, dap = pcall(require, 'dap')
if status_ok then
  local function set_cond_breakpoint()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end

  local function set_log_point()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end

  mapn('<F5>',       dap.continue,          '[DAP] Continue')
  mapn('<F10>',      dap.step_over,         '[DAP] Step over')
  mapn('<F11>',      dap.step_into,         '[DAP] Step into')
  mapn('<F12>',      dap.step_out,          '[DAP] Step out')
  mapn('<F9>',       dap.toggle_breakpoint, '[DAP] Toggle breakpoint')
  mapn('<Leader>B',  set_cond_breakpoint,   '[DAP] Set conditional breakpoint')
  mapn('<Leader>lp', set_log_point,         '[DAP] Set log point')
  mapn('<Leader>dr', dap.repl.open,         '[DAP] Open repl')
  mapn('<Leader>dl', dap.run_last,          '[DAP] Run last')
else
  vim.notify('Error. DAP not found')
end

-- Hop.nvim
mapa('f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR,  current_line_only = true })<cr>", '[HOP] Jump to symbol')
mapa('F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", '[HOP] Jump back to symbol')
mapa('t', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 })<cr>", '[HOP] Jump before symbol')
mapa('T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", '[HOP] Jump back before symbol')

map('', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", '[HOP] Jump to word')

-- EasyAlign
map('x', 'ga', '<Plug>(EasyAlign)', '[EasyAlign] Start interactive EasyAlign in visual mode')
mapn('ga', '<Plug>(EasyAlign)', '[EasyAlign] Start interactive EasyAlign for a motion/text object')


-- ToggleTerm
mapn('<space>tb', ':ToggleTerm direction=horizontal<CR>', '[ToggleTerm] Open terminal below')
mapn('<space>tl', ':ToggleTerm direction=vertical<CR>',   '[ToggleTerm] Open terminal left')

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], '[ToggleTerm] Go to left pane',  opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], '[ToggleTerm] Go to down pane',  opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], '[ToggleTerm] Go to up pane',    opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], '[ToggleTerm] Go to right pane', opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Bufdelete
status_ok, _ = pcall(require, 'bufdelete')
if status_ok then
  mapn('<leader>d', '<cmd>Bd<CR>', '[Bufdelete] Delete buffer')
  mapn('<leader>w', '<cmd>Bw<CR>', '[Bufdelete] Wipe buffer')
else
  mapn('<leader>d', '<cmd>bd<CR>', 'Delete buffer')
  mapn('<leader>w', '<cmd>bw<CR>', 'Wipe buffer')
end

-- Hard mode :D
map({'n', 'v'}, '<Up>',    '<Nop>', '[Hard mode :D] Disable UP key')
map({'n', 'v'}, '<Down>',  '<Nop>', '[Hard mode :D] Disable DOWN key')
map({'n', 'v'}, '<Left>',  '<Nop>', '[Hard mode :D] Disable LEFT key')
map({'n', 'v'}, '<Right>', '<Nop>', '[Hard mode :D] Disable RIGHT key')

-- CP command
vim.cmd([[
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction
]])

--------------- Callbacks for plugins `on_attach` functions ---------------

M = {}

M.nvim_tree = function (bufnr)
  local api = require('nvim-tree.api')
  local opts = { buffer = bufnr, noremap = true, nowait = true }

  api.config.mappings.default_on_attach(bufnr)

  mapn('l',    api.node.open.edit,             '[NVIM-TREE] Open',                 opts)
  mapn('<CR>', api.node.open.edit,             '[NVIM-TREE] Open',                 opts)
  mapn('o',    api.node.open.edit,             '[NVIM-TREE] Open',                 opts)
  mapn('h',    api.node.navigate.parent_close, '[NVIM-TREE] Close Directory',      opts)
  mapn('v',    api.node.open.vertical,         '[NVIM-TREE] Open: Vertical Split', opts)
end

return M
