return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.indentscope').setup {
      delay = 250,
    }
    require('mini.animate').setup {
      cursor = {
        timing = require('mini.animate').gen_timing.linear { duration = 5 },
      },
      scroll = {
        timing = require('mini.animate').gen_timing.linear { duration = 5 },
      },
    }
  end,
}
