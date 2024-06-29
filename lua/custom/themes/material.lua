return {
  'marko-cerovac/material.nvim',
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    require('material').setup {
      theme = 'auto',
      disable = {
        background = true,
      },
    }
    vim.cmd.colorscheme 'material'
  end,
}
