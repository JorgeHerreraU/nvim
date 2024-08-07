return {
  'rebelot/kanagawa.nvim',
  enabled = true,
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
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
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
