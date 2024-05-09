local utils = require 'utils'
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

vim.keymap.set('n', '<c-d>', utils.lazy '<c-d>zz', { desc = 'Scroll down half screen' })

vim.keymap.set('n', '<C-m>', utils.expand_braces, { desc = 'Expand curly braces' })
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
