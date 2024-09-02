return {
  enabled = true,
  'dgox16/oldworld.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('oldworld').setup {
      integrations = {
        neo_tree = true,
        telescope = true,
      },
      highlight_overrides = {
        Normal = { bg = 'NONE' },
        NormalFloat = { bg = 'NONE' },
        NormalNC = { bg = 'NONE' },
        Pmenu = { bg = 'NONE' },
        StatusLine = { bg = 'NONE', fg = '#c6c6c6' },
        StatusLineNC = { bg = 'NONE' },
        SignColumn = { bg = 'NONE' },
        FloatBorder = { bg = 'NONE' },
        FloatTitle = { bg = 'NONE' },
        LineNr = { fg = '#c6c6c6' },
        CursorLine = { bg = 'NONE' },
      },
    }
    vim.cmd.colorscheme 'oldworld'
    vim.cmd [[
      hi TelescopeNormal guibg=NONE ctermbg=NONE
      hi TelescopeBorder guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopePromptNormal guibg=NONE ctermbg=NONE
      hi TelescopePromptBorder guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopePromptTitle guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopePreviewNormal guibg=NONE ctermbg=NONE
      hi TelescopePreviewBorder guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopePreviewTitle guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopeResultsNormal guibg=NONE ctermbg=NONE
      hi TelescopeResultsBorder guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopeResultsTitle guibg=NONE ctermbg=NONE guifg=#c6c6c6
      hi TelescopePromptCounter guibg=NONE ctermbg=NONE guifg=#c6c6c6
    ]]
    vim.defer_fn(function()
      vim.cmd [[
        hi lualine_c_inactive guifg=#c6c6c6
        hi DapUIPlayPauseNC guibg=NONE
        hi DapUIRestartNC guibg=NONE
        hi DapUIUnavailableNC guibg=NONE guifg=#c6c6c6
        hi WinBar guibg=NONE
        hi WinBarNC guibg=NONE
      ]]
    end, 250)
  end,
}
