return {
  enabled = false,
  lazy = false,
  priority = 1000,
  'mellow-theme/mellow.nvim',
  config = function()
    vim.cmd.colorscheme 'mellow'
  end,
}
