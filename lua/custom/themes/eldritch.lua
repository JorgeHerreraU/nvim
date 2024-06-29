return {
  'eldritch-theme/eldritch.nvim',
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    require('eldritch').setup {
      transparent = true,
      styles = {
        floats = 'transparent',
      },
    }
    vim.cmd.colorscheme 'eldritch'
  end,
}
