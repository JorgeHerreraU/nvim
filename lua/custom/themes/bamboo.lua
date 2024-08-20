return {
  'ribru17/bamboo.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('bamboo').setup {
      transparent = true,
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      colors = {
        contrast = '#111210',
        inverse = '#ffffff',
        bg0 = '#252623',
        bg1 = '#2f312c',
        bg2 = '#383b35',
        bg3 = '#3a3d37',
        bg_d = '#1c1e1b',
        bg_blue = '#68aee8',
        bg_yellow = '#e2c792',
        fg = '#E6E6E6',
        purple = '#aaaaff',
        bright_purple = '#df73ff',
        green = '#e2c792',
        orange = '#e4e7f7',
        blue = '#c6c4ff',
        light_blue = '#96c7ef',
        yellow = '#C599FF',
        cyan = '#E6E6E6',
        red = '#E6E6E6',
        coral = '#c9deff',
        grey = '#5b5e5a',
        light_grey = '#838781',
        diff_add = '#40531b',
        diff_delete = '#893f45',
        diff_change = '#2a3a57',
        diff_text = '#3a4a67',
      },
      highlights = {
        ['@comment'] = { fg = '#238D65' },
      },
    }
    require('bamboo').load()
  end,
}
