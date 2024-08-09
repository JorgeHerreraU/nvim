return {
  'catppuccin/nvim',
  enabled = false,
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      transparent_background = true,
      custom_highlights = {
        LineNr = { fg = '#C5C8C6' },
      },
    }
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
