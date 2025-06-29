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

local function mapx(keys, command, description, additional)
  map('x', keys, command, description, additional)
end

local function adjust_font_size(amount)
  local font_full = vim.api.nvim_get_option_value('guifont', {})
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

mapn('<Leader>ve', ':cd ~/.config/nvim/ <BAR> e init.lua<CR>', '[Config] Quick edit of config')

mapn('<Tab>',   ':bnext<CR>',     '[Buffer] Next buffer')
mapn('<S-Tab>', ':bprevious<CR>', '[Buffer] Previous buffer')
mapv('>',       '>gv',            '[Indent] Indent in visual mode vithout leaving to normal mode')
mapv('<',       '<gv',            '[Indent] Unindent in visual mode vithout leaving to normal mode')

mapn('-',     decrement_font_size, '[GUI] Increase font size')
mapn('+',     increment_font_size, '[GUI] Decrease font size')
mapi('<C-->', decrement_font_size, '[GUI] Increase font size')
mapi('<C-+>', increment_font_size, '[GUI] Decrease font size')

mapn('<leader>fn', "i <C-R>=expand('%:t:r')<CR>", '[MISC] Paste filename of current buffer')
mapi('<C-f><C-n>', "<C-R>=expand('%:t:r')<CR>", '[MISC] Paste filename of current buffer')

local smartSplits = require("smart-splits")
mapn('<C-A-h>',           smartSplits.resize_left,       '[SmartSplits] Resize buffer left')
mapn('<C-A-j>',           smartSplits.resize_down,       '[SmartSplits] Resize buffer down')
mapn('<C-A-k>',           smartSplits.resize_up,         '[SmartSplits] Resize buffer up')
mapn('<C-A-l>',           smartSplits.resize_right,      '[SmartSplits] Resize buffer right')

mapn('<C-h>',             smartSplits.move_cursor_left,  '[SmartSplits] Move to left buffer')
mapn('<C-j>',             smartSplits.move_cursor_down,  '[SmartSplits] Move to down buffer')
mapn('<C-k>',             smartSplits.move_cursor_up,    '[SmartSplits] Move to up buffer')
mapn('<C-l>',             smartSplits.move_cursor_right, '[SmartSplits] Move to right buffer')

mapn('<leader><leader>h', smartSplits.swap_buf_left,     '[SmartSplits] Swap buffer left')
mapn('<leader><leader>j', smartSplits.swap_buf_down,     '[SmartSplits] Swap buffer down')
mapn('<leader><leader>k', smartSplits.swap_buf_up,       '[SmartSplits] Swap buffer up')
mapn('<leader><leader>l', smartSplits.swap_buf_right,    '[SmartSplits] Swap buffer right')

mapn('<A-j>',      ':MoveLine(1)<CR>',    '[Move] Move line down')
mapn('<A-k>',      ':MoveLine(-1)<CR>',   '[Move] Move line up')
mapn('<A-l>',      ':MoveHChar(1)<CR>',   '[Move] Move char right')
mapn('<A-h>',      ':MoveHChar(-1)<CR>',  '[Move] Move char left')
mapn('<leader>wf', ':MoveWord(1)<CR>',    '[Move] Move word right')
mapn('<leader>wb', ':MoveWord(-1)<CR>',   '[Move] Move word left')
mapv('<A-j>',      ':MoveBlock(1)<CR>',   '[Move] Move block down')
mapv('<A-k>',      ':MoveBlock(-1)<CR>',  '[Move] Move block up')
mapv('<A-l>',      ':MoveHBlock(1)<CR>',  '[Move] Move block right')
mapv('<A-h>',      ':MoveHBlock(-1)<CR>', '[Move] Move block left')

-- NeogitRel
mapn('<leader>g', ":NeogitRel<CR>", '[Neogit] Open Neogit')

mapn('<C-n>',     ':NvimTreeFindFileToggle<CR>', '[NvimTree] Toggle NvimTree')

-- LSP

mapn('<leader>q', vim.diagnostic.setloclist, '[LSP] Send diagnostics to loclist')
mapn('<leader>e', vim.diagnostic.open_float, '[LSP] Open floating window with diagnostic')

local diag_loc_error = { severity = vim.diagnostic.severity.ERROR }
local status_ok, lspsaga = pcall(require, "lspsaga")
if status_ok then
  mapn('<leader>gh', '<cmd>Lspsaga finder<CR>',                                   '[LSP] Open finder')
  mapn('K',          '<cmd>Lspsaga hover_doc<CR>',                                '[LSP] Open hover window')
  mapn('[d',         '<cmd>Lspsaga diagnostic_jump_prev<CR>',                     '[LSP] Goto previous diagnostic')
  mapn(']d',         '<cmd>Lspsaga diagnostic_jump_next<CR>',                     '[LSP] Goto next diagnostic')
  mapn("[D",         function() lspsaga.diagnostic.goto_prev(diag_loc_error) end, '[LSP] Jump to previous error')
  mapn("]D",         function() lspsaga.diagnostic.goto_next(diag_loc_error) end, '[LSP] Jump to next error')
  mapn('<space>o',   '<cmd>Lspsaga outline<CR>',                                  '[LSP] Open outline'            )
  mapn('gp',         '<cmd>Lspsaga peek_definition<CR>',                          '[LSP] Peek definition'         )
  mapn('<space>rn',  '<cmd>Lspsaga rename<CR>"',                                  '[LSP] Rename selected element' )
  mapn('<space>ca',  '<cmd>Lspsaga code_action<CR>',                              '[LSP] Open code action pop-up' )
else
  local d = vim.diagnostic
  mapn('K',         vim.lsp.buf.hover,                                                 '[LSP] Open hover window')
  mapn('[d',        function() d.jump({ diagnostic = d.get_prev()}) end,               '[LSP] Goto previous diagnostic')
  mapn(']d',        function() d.jump({ diagnostic = d.get_next()}) end,               '[LSP] Goto previous diagnostic')
  mapn('[D',        function() d.jump({ diagnostic = d.get_prev(diag_loc_error)}) end, '[LSP] Goto previous diagnostic')
  mapn(']D',        function() d.jump({ diagnostic = d.get_next(diag_loc_error)}) end, '[LSP] Goto previous diagnostic')
  mapn('<space>rn', vim.lsp.buf.rename,                                                '[LSP] Rename selected element' )
  mapn('<space>ca', vim.lsp.buf.code_action,                                           '[LSP] Open code action pop-up' )
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function (ev)
    local opts = { buffer = ev.buf }
    mapn('gd',           vim.lsp.buf.definition,              '[LSP] Go to definition',        opts)
    mapn('gD',           vim.lsp.buf.declaration,             '[LSP] Go to declaration',       opts)
    mapn('gi',           vim.lsp.buf.implementation,          '[LSP] Go to implementation',    opts)
    mapn('gr',           vim.lsp.buf.references,              '[LSP] Find all references',     opts)
    mapn('<space><C-k>', vim.lsp.buf.signature_help,          '[LSP] Signature help',          opts)
    mapn('<space>wa',    vim.lsp.buf.add_workspace_folder,    '[LSP] Add workspace folder',    opts)
    mapn('<space>wr',    vim.lsp.buf.remove_workspace_folder, '[LSP] Remove workspace folder', opts)
    mapn('<space>D',     vim.lsp.buf.type_definition,         '[LSP] Open type definition',    opts)

    mapn('<space>wl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[LSP] List workspace folders', opts)
    mapn('<space>bf', function () require'custom.lsp-stuff'.lsp_formatting(ev.buf) end,         '[LSP] Format buffer',          opts)
  end,
})

-- QuickFix

mapn('<leader>lo', '<cmd> lua require"qf".open("l")        <CR>', '[QuickFix] Open location list')
mapn('<leader>lc', '<cmd> lua require"qf".close("l")       <CR>', '[QuickFix] Close location list')
mapn('<leader>ll', '<cmd> lua require"qf".toggle("l",true) <CR>', '[QuickFix] Toggle location list and stay in current window')
mapn('<leader>co', '<cmd> lua require"qf".open("c")        <CR>', '[QuickFix] Open quickfix list')
mapn('<leader>cc', '<cmd> lua require"qf".close("c")       <CR>', '[QuickFix] Close quickfix list')
mapn('<leader>cl', '<cmd> lua require"qf".toggle("c",true) <CR>', '[QuickFix] Toggle quickfix list and stay in current window')
mapn('<leader>j',  '<cmd> lua require"qf".below("l")       <CR>', '[QuickFix] Go to next location list entry from cursor')
mapn('<leader>k',  '<cmd> lua require"qf".above("l")       <CR>', '[QuickFix] Go to previous location list entry from cursor')
mapn('<leader>J',  '<cmd> lua require"qf".below("c")       <CR>', '[QuickFix] Go to next quickfix entry from cursor')
mapn('<leader>K',  '<cmd> lua require"qf".above("c")       <CR>', '[QuickFix] Go to previous quickfix entry from cursor')
mapn(']q',         '<cmd> lua require"qf".below("visible") <CR>', '[QuickFix] Go to next entry from cursor in visible list')
mapn('[q',         '<cmd> lua require"qf".above("visible") <CR>', '[QuickFix] Go to previous entry from cursor in visible list')

local dap = require ('dap')

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

-- dapui
mapn('<S-A-k>', require("dap.ui.widgets").hover, '[DAP] hover var')

-- Hop.nvim
local hop, hint = require("hop"), require("hop.hint")
mapa('f', function () hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR,  current_line_only = true }) end,                   '[HOP] Jump to symbol')
mapa('F', function () hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true }) end,                   '[HOP] Jump back to symbol')
mapa('t', function () hop.hint_char1({ direction = hint.HintDirection.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 }) end, '[HOP] Jump before symbol')
mapa('T', function () hop.hint_char1({ direction = hint.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 }) end, '[HOP] Jump back before symbol')
mapa('<leader>jw', function () hop.hint_words({ hint_position = hint.HintPosition.END }) end, '[HOP] Jump to word')

-- EasyAlign
mapx('ga', '<Plug>(EasyAlign)', '[EasyAlign] Start interactive EasyAlign in visual mode')
mapn('ga', '<Plug>(EasyAlign)', '[EasyAlign] Start interactive EasyAlign for a motion/text object')

-- Bufdelete
status_ok, _ = pcall(require, 'bufdelete')
if status_ok then
  mapn('<leader>d', '<cmd>Bd<CR>', '[Bufdelete] Delete buffer')
  mapn('<leader>w', '<cmd>Bw<CR>', '[Bufdelete] Wipe buffer')
else
  mapn('<leader>d', '<cmd>bd<CR>', 'Delete buffer')
  mapn('<leader>w', '<cmd>bw<CR>', 'Wipe buffer')
end

-- Substitute.nvim
local substitute = require('substitute')
mapn('cp',  substitute.operator, '[Substitute] Substitute operator')
mapn('cpp', substitute.line,     '[Substitute] Substitute line')
mapn('cP',  substitute.eol,      '[Substitute] Substitute until end of line')
mapx('cp',  substitute.visual,   '[Substitute] Substitute in visual mode')

local subsrange = require'substitute.range'
mapn('<Leader>cp',  subsrange.operator, '[Substitute] Substitute ranged operator')
mapx('<Leader>cp',  subsrange.visual,   '[Substitute] Substitute ranged in visual mode')
mapn('<Leader>cpp', subsrange.word,     '[Substitute] Substitute ranged word')

local subsex = require'substitute.exchange'
mapn('cpx',  subsex.operator, '[Substitute] Exchange operator')
mapn('cppx', subsex.line,     '[Substitute] Exchange line')
mapx('cpx',  subsex.visual,   '[Substitute] Exchange in visual mode')
mapn('cpxc', subsex.cancel,   '[Substitute] Exchange cancel')

mapn('<Leader>x', '<cmd>Compile<CR>', '[Compile] Launch compilation mode')

-- Hard mode :D
map({ 'n', 'v' }, '<Up>', '<Nop>', '[Hard mode :D] Disable UP key')
map({ 'n', 'v' }, '<Down>', '<Nop>', '[Hard mode :D] Disable DOWN key')
map({'n', 'v'}, '<Left>',  '<Nop>', '[Hard mode :D] Disable LEFT key')
map({'n', 'v'}, '<Right>', '<Nop>', '[Hard mode :D] Disable RIGHT key')

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

-- telescope
M.setup_telescope_keymaps = function ()
  local t, tb = require("telescope"), require("telescope.builtin")
  mapn('<leader>ff', tb.find_files,                              '[Telescope] Find files')
  mapn('<leader>fg', tb.git_files,                               '[Telescope] Find git files')
  mapn('<leader>fb', tb.buffers,                                 '[Telescope] Find buffer')
  mapn('<leader>fh', tb.help_tags,                               '[Telescope] Find help')
  mapn('<leader>fr', tb.oldfiles,                                '[Telescope] Find recent')
  mapn('<leader>fm', tb.man_pages,                               '[Telescope] Find map pages')
  mapn('<leader>fa', t.extensions.live_grep_args.live_grep_args,        '[Telescope] Find string')
  mapn('<leader>fi', function () tb.find_files({ no_ignore=true }) end, '[Telescope] Find files without ignore')

end

return M
