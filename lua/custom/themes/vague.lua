return {
  'vague2k/vague.nvim',
  enabled = false,
  config = function()
    require('vague').setup {
      transparent = true,
      -- optional configuration here
    }
    vim.cmd.colorscheme 'vague'
  end,
}
