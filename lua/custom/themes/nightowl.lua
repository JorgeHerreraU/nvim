return {
  'oxfist/night-owl.nvim',
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'night-owl'
  end,
}
