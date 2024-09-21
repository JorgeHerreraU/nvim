return {
  'echasnovski/mini.surround',
  version = '*',
  config = function()
    require('mini.surround').setup {
      mappings = {
        add = 'gza', -- Add surrounding in Normal and Visual modes
        delete = 'gzd', -- Delete surrounding
        replace = 'gzr', -- Replace surrounding
      },
    }

    local wk = require 'which-key'
    wk.add {
      { 'gz', group = 'Surround', icon = '' },
    }
  end,
}
