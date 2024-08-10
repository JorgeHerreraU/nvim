return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.indentscope').setup {
      delay = 250,
    }
  end,
}
