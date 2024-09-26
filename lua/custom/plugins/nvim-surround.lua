return {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      keymaps = {
        insert = '<C-g>z',
        insert_line = 'gC-ggZ',
        normal = 'gz',
        normal_cur = 'gZ',
        normal_line = 'gzgz',
        normal_cur_line = 'gZgZ',
        visual = 'gz',
        visual_line = 'gZ',
        delete = 'gzd',
        change = 'gzc',
      },
    }
    local wk = require 'which-key'
    wk.add {
      { 'gz', group = 'surround', icon = { icon = '', color = 'yellow' } },
      { 'gz$', icon = '', desc = 'end of line' },
      { 'gzi', icon = '', desc = 'inside' },
      { 'gziw', icon = '', desc = 'inner word' },
      { 'gziW', icon = '', desc = 'inner WORD' },
      { 'gzib', icon = '', desc = 'inner []' },
      { 'gziB', icon = '', desc = 'inner {}' },
      { 'gzii', icon = '', desc = 'Object scope' },
      { 'gzip', icon = '', desc = 'inner paragraph' },
      { 'gzis', icon = '', desc = 'inner sentence' },
      { 'gzit', icon = '', desc = 'inner tag block' },
      { 'gziW', icon = '', desc = 'inner WORD' },
      { 'gzi(', icon = '', desc = 'inner ()' },
      { 'gzi)', icon = '', desc = 'inner ()' },
      { 'gzi[', icon = '', desc = 'inner []' },
      { 'gzi]', icon = '', desc = 'inner []' },
      { 'gzi{', icon = '', desc = 'inner {}' },
      { 'gzi}', icon = '', desc = 'inner {}' },
      { 'gzi<', icon = '', desc = 'inner <>' },
      { 'gzi>', icon = '', desc = 'inner <>' },
    }
  end,
}
