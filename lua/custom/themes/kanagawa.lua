return {
  'rebelot/kanagawa.nvim',
  enabled = false,
  config = function()
    require('kanagawa').setup {
      transparent = true,
      keywordStyle = { italic = true, bold = false },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          Pmenu = { bg = 'none' },
          -- Telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = 'none' },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = 'none' },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = 'none' },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = 'none' },
          TelescopePreviewNormal = { bg = 'none' },
          TelescopePreviewBorder = { bg = 'none', fg = theme.ui.bg_dim },
          -- Statusbar
          StatusLine = { bg = 'none' },
          StatusLineNC = { bg = 'none' },
          MsgSeparator = { bg = 'none' },
        }
      end,
    }
    vim.cmd 'colorscheme kanagawa'
  end,
}
