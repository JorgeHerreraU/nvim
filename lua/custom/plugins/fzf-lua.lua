return {
  'ibhagwan/fzf-lua',
  config = function()
    vim.keymap.set('n', '<c-P>', require('fzf-lua').files, { desc = 'Fzf Files' })
    vim.keymap.set('n', '<leader>fG', require('fzf-lua').grep, { desc = 'Find: Fzf Grep' })
    vim.keymap.set('n', '<leader>/', require('fzf-lua').live_grep, { desc = 'Find: Fzf LiveGrep' })
    require('fzf-lua').setup {}
  end,
}
