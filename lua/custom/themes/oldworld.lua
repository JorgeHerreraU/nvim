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
        Visual = { bg = '#214283' },
        PmenuSel = { bg = '#82ffac', fg = '#000000' },
        CmpBorder = { fg = '#c6c6c6' },
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
      hi ModeMsg guibg=NONE ctermbg=NONE guifg=#c6c6c6
    ]]
    vim.defer_fn(function()
      vim.cmd [[
        hi lualine_a_inactive guifg=#8f8e7b
        hi lualine_b_inactive guifg=#c6c6c6
        hi lualine_c_inactive guifg=#c6c6c6
        hi DapUIPlayPauseNC guibg=NONE
        hi DapUIRestartNC guibg=NONE
        hi DapUIUnavailableNC guibg=NONE guifg=#c6c6c6
        hi WinBar guibg=NONE
        hi WinBarNC guibg=NONE
        hi DapUIStopNC guibg=NONE
        hi DapUIStepOverNC guibg=NONE
        hi DapUIStepIntoNC guibg=NONE
        hi DapUIStepBackNC guibg=NONE
        hi DapUIStepOutNC guibg=NONE
      ]]
    end, 1000)
  end,
}
