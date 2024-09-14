return {
  'typed-rocks/ts-worksheet-neovim',
  opts = {
    severity = vim.diagnostic.severity.WARN,
  },
  config = function(_, opts)
    require('tsw').setup(opts)
    vim.keymap.set('n', '<leader>lt', '<cmd>Tsw show_variables=true<CR>', { desc = 'Typedrocks Live Results' })
  end,
}
