return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    local utils = require 'utils'
    local custom_theme = require 'lualine.themes.auto'
    -- Function to recursively set background to 'none'
    local function set_bg_none(tbl)
      for k, v in pairs(tbl) do
        if type(v) == 'table' then
          if k ~= 'a' and v.bg then
            v.bg = 'none'
          end
          set_bg_none(v)
        end
      end
    end

    -- Apply transparent background to all theme sections
    set_bg_none(custom_theme)
    require('lualine').setup {
      options = {
        theme = custom_theme,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        globalstatus = false,
        disabled_filetypes = { statusline = { 'NvimTree', 'alpha' } },
      },
      sections = {
        lualine_a = { { 'mode', icon = '' } },
        lualine_b = { { '', icon = '', color = { bg = 'none' } } },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = '󰝶 ',
            },
            color = { bg = 'none' },
          },
          {
            'filetype',
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
            color = { bg = 'none' },
          },
          { 'filename', padding = { left = 1, right = 0 }, color = { bg = 'none' } },
        },
        lualine_x = {
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = utils.get_hlgroup 'String',
          },
          { 'diff', color = { bg = 'none' } },
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
