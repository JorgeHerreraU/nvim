return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    cmdline = {
      view = 'cmdline',
      format = {
        cmdline = { icon = '' },
      },
    },
    views = {
      hover = {
        anchor = 'SW',
        position = {
          row = -2,
          col = 0,
        },
        size = {
          height = 8,
          width = 'auto',
        },
      },
    },
  },
}
