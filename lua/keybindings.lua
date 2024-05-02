-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- save file
vim.keymap.set('n', '<C-s>', ':w!<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>l', { desc = 'Save file' })

-- nvimtree
vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Nvimtree toggle window' })

-- fterm
vim.keymap.set('n', '<F7>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<F7>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

--[[ vim.keymap.set({ 'n' }, '<C-k>', function()
  require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' }) ]]

vim.keymap.set({ 'i' }, '<F3>', vim.lsp.buf.code_action, { desc = 'Code action' })

local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    local old = vim.o.lazyredraw
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, 'nx', false)
    vim.o.lazyredraw = old
  end
end

vim.keymap.set('n', '<c-d>', lazy '<c-d>zz', { desc = 'Scroll down half screen' })

-- expand curly braces c# style
local function remove_braces(line)
  return line:gsub('%s*{%s*}', '')
end

local function create_braces_block(trimmed_line, indent)
  local new_lines = { trimmed_line }
  table.insert(new_lines, indent .. '{')
  table.insert(new_lines, indent .. '    ')
  table.insert(new_lines, indent .. '}')
  return new_lines
end

local function expand_braces()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_num = vim.fn.getcurpos()[2] - 1
  local line = vim.api.nvim_buf_get_lines(bufnr, line_num, line_num + 1, false)[1]
  local indent = line:match '^%s*'

  if line:find '{%s*}' then
    local trimmed_line = remove_braces(line)
    local new_lines = create_braces_block(trimmed_line, indent)

    vim.api.nvim_buf_set_lines(bufnr, line_num, line_num + 1, false, new_lines)
    vim.api.nvim_win_set_cursor(0, { line_num + 3, #indent + 4 })
    vim.cmd 'startinsert!'
  end
end

vim.keymap.set('n', '<C-m>', expand_braces, { desc = 'Expand curly braces' })
-- copy contents
vim.keymap.set('n', '<C-c>', '"+yy', { desc = 'Copy the current line to the clipboard' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy the selection to the clipboard' })

-- bind noh to escape
vim.keymap.set('n', '<esc>', ':noh<cr>', { desc = 'No highlight', silent = true })

-- resize
vim.keymap.set('n', '<C-Right>', ':vertical resize +5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -5<CR>', { noremap = true, silent = true })

-- Keybinding to disable autoformatting
vim.keymap.set('n', '<F4>', ':FormatDisable<CR>', { desc = 'Disable autoformat-on-save' })

-- Keybinding to enable autoformatting
vim.keymap.set('n', '<F6>', ':FormatEnable<CR>', { desc = 'Enable autoformat-on-save' })
