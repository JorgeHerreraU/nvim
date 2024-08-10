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
        fg = '#f1e9d2',
        purple = '#aaaaff',
        bright_purple = '#df73ff',
        green = '#e2c792',
        orange = '#ff9966',
        blue = '#57a5e5',
        light_blue = '#96c7ef',
        yellow = '#C599FF',
        cyan = '#f1e9d2',
        red = '#f1e9d2',
        coral = '#f1e9d2',
        grey = '#5b5e5a',
        light_grey = '#838781',
        diff_add = '#40531b',
        diff_delete = '#893f45',
        diff_change = '#2a3a57',
        diff_text = '#3a4a67',
      },
    }
    require('bamboo').load()
  end,
}
