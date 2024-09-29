local utils = require 'utils'
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous Diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next Diagnostic message' })
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
vim.keymap.set('n', '<C-s>', ':w!<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>l', { desc = 'Save file', silent = true })

-- nvimtree
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Explorer' })

-- fterm
vim.keymap.set('n', '<c-e>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<c-e>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

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

-- Keybinding to toggle autoformatting
vim.keymap.set('n', '<leader>ta', utils.toggle_autoformat, { desc = 'Toggle autoformat', noremap = true, silent = true })

-- Quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })

-- Next buffer
vim.keymap.set('n', '<leader>a', ':bnext<CR>', { desc = 'Next Buffer' })

-- Close all buffers except current
vim.api.nvim_set_keymap('n', '<leader>c', [[:%bd|e#|bd#<CR>|'"`]], { noremap = true, silent = true, desc = 'Close all other buffers' })

-- Close current buffer
vim.api.nvim_set_keymap('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })

-- Delete without yank
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete without yank' })

-- Remap visual block mode
vim.keymap.set('n', '<A-v>', '<C-v>')

-- Line pseudo-text objects (https://gist.github.com/romainl/c0a8b57a36aec71a986f1120e1931f20#file-pseudo-text-objects-vim-L13)
vim.keymap.set('x', 'il', 'g_o^', { desc = 'Inner line text object' })
vim.keymap.set('o', 'il', ':<C-u>normal vil<CR>', { desc = 'Inner line text object' })
vim.keymap.set('x', 'al', '$o0', { desc = 'Around line text object' })
vim.keymap.set('o', 'al', ':<C-u>normal val<CR>', { desc = 'Around line text object' })

-- Toggle supermaven
vim.keymap.set('n', '<leader>tm', utils.toggle_supermaven, { desc = 'Toggle supermaven' })

-- Previous buffer
vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })

-- Next buffer
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })

-- Copy previous line till the end of line
vim.keymap.set('i', '<c-y>', utils.copy_line_above, { noremap = true, silent = true })
