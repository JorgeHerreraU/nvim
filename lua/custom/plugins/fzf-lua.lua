return {
  'ibhagwan/fzf-lua',
  config = function()
    require('fzf-lua').setup {
      vim.keymap.set('n', '<c-P>', require('fzf-lua').files, { desc = 'Fzf Files' }),
    }
  end,
}
