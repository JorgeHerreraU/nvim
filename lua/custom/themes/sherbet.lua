return {
  enabled = false,
  lazy = false,
  priority = 1000,
  'lewpoly/sherbet.nvim',
  config = function()
    vim.cmd.colorscheme 'sherbet'
  end,
}
