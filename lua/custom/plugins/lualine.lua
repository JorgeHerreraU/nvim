return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function()
    local utils = require 'utils'
    return {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = false,
        disabled_filetypes = { statusline = { 'NvimTree', 'alpha' } },
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = { { '', icon = '' } },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = '󰝶 ',
            },
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { 'filename', padding = { left = 1, right = 0 } },
        },
        lualine_x = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = utils.get_hlgroup 'String',
          },
          { 'diff' },
        },
        lualine_y = {
          -- {
          --   'progress',
          -- },
          -- {
          --   'location',
          --   color = utils.get_hlgroup 'Boolean',
          -- },
        },
        lualine_z = {
          -- {
          --   'datetime',
          --   style = '  %X',
          -- },
        },
      },
      extensions = { 'lazy', 'toggleterm', 'mason' },
    }
  end,
}
