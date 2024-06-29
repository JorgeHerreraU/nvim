return {
  'ellisonleao/gruvbox.nvim',
  enabled = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      transparent_mode = true,
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
