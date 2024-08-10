return {
  'chrsm/paramount-ng.nvim',
  enabled = false,
  dependencies = {
    'rktjmp/lush.nvim',
  },
  config = function()
    vim.cmd.colorscheme 'paramount-ng'
  end,
}
