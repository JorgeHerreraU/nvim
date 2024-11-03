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

        -- Virtual text colors (shown inline)
        DiagnosticVirtualTextError = { fg = '#ff9ea8' },
        DiagnosticVirtualTextWarn = { fg = '#d6ccdb' },
        DiagnosticVirtualTextInfo = { fg = '#d6ccdb' },
        DiagnosticVirtualTextHint = { fg = '#d6ccdb' },

        DiagnosticUnnecessary = { fg = '#545c7e' },

        -- Add these new highlight groups
        ['@string'] = { fg = '#C0AD97' },
        ['@string.regex'] = { fg = '#C3E88D' },
        ['@string.escape'] = { fg = '#89DDFF' },
        ['@boolean'] = { fg = '#C792EA' },

        -- Brackets and parentheses
        ['@punctuation.bracket'] = { fg = '#d6ccdb' }, -- For square and curly brackets
        ['@punctuation.delimiter'] = { fg = '#d6ccdb' }, -- For parentheses

        -- Supported semantic token types from your server
        ['@lsp.type.namespace'] = { fg = '#EA83A5' },
        ['@lsp.type.type'] = { fg = '#C792EA' },
        ['@lsp.type.class'] = { fg = '#C9C7CD' },
        ['@lsp.type.enum'] = { fg = '#E6B99D' },
        ['@lsp.type.interface'] = { fg = '#82AAFF' },
        ['@lsp.type.struct'] = { fg = '#FFCB6B' },
        ['@lsp.type.parameter'] = { fg = '#9c82c6' },
        ['@lsp.type.variable'] = { fg = '#C9C7CD' },
        ['@lsp.type.property'] = { fg = '#C9C7CD' },
        ['@lsp.type.enumMember'] = { fg = '#89DDFF' },
        ['@lsp.type.event'] = { fg = '#82AAFF' },
        ['@lsp.type.function'] = { fg = '#82AAFF' },
        ['@lsp.type.method'] = { fg = '#82AAFF' },
        ['@lsp.type.macro'] = { fg = '#C792EA' },
        ['@lsp.type.decorator'] = { fg = '#C792EA' },
        ['@lsp.type.constant'] = { fg = '#FF5370', italic = true },
        ['@lsp.type.field'] = { fg = '#C9C7CD' },

        -- Supported modifiers from your server
        ['@lsp.typemod.variable.static'] = { italic = true },
        ['@lsp.typemod.variable.static'] = { italic = true },
        ['@lsp.typemod.class.static'] = { italic = true },
        ['@lsp.typemod.property.static'] = { italic = true },
        ['@lsp.typemod.field.static'] = { italic = true },
        ['@lsp.typemod.variable.ReassignedVariable'] = { italic = true },
        ['@lsp.mod.deprecated'] = { strikethrough = true },
        Comment = { fg = '#4E5163' },
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
