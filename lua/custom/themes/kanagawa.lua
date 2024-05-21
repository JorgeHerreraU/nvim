return {
  'rebelot/kanagawa.nvim',
  enabled = true,
  config = function()
    require('kanagawa').setup {
      overrides = function(colors)
        local theme = colors.theme
        return {
          Keyword = { fg = '#8183FA' },
          Type = { fg = '#D2CFCF' },
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
      vim.cmd.colorscheme 'kanagawa',
      vim.cmd 'highlight FloatBorder guibg=NONE',
      vim.cmd 'highlight LineNr guibg=NONE',
      vim.cmd 'highlight SignColumn guibg=NONE',
      vim.cmd 'highlight DiagnosticSignError guifg=#E67CA3 guibg=NONE',
      vim.cmd 'highlight DiagnosticSignWarn guifg=#FFA500 guibg=NONE',
      vim.cmd 'highlight DiagnosticSignHint guifg=#B6B5D2 guibg=NONE',
      vim.cmd 'highlight DiagnosticSignInfo guifg=#B6B5D2 guibg=NONE',
      vim.cmd 'highlight GitSignsAdd guifg=#00FF00 guibg=NONE',
      vim.cmd 'highlight GitSignsChange guifg=#FFFF00 guibg=NONE',
      vim.cmd 'highlight GitSignsDelete guifg=#FF0000 guibg=NONE',
      vim.cmd 'highlight GitSignsTopDelete guifg=#FF00FF guibg=NONE',
      vim.cmd 'highlight GitSignsChangeDelete guifg=#00FFFF guibg=NONE',
      vim.cmd 'highlight Keyword guifg=#8183FA',
      vim.cmd 'highlight Type guifg=#D2CFCF',
    }
  end,
}
