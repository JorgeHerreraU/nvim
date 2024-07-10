---@diagnostic disable: missing-fields
return {
  'folke/tokyonight.nvim',
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      style = 'night',
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.none
      end,
    }
    vim.cmd.colorscheme 'tokyonight'
    vim.api.nvim_set_hl(0, 'LspInlayHint', { bg = 'None', fg = '#8a8a8a' })
    vim.api.nvim_set_hl(0, 'CmpBorder', { fg = '#3b4261', bg = 'NONE' })
  end,
}
