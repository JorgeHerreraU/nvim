return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#E06C75', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5C07B', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#61AFEF', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#D19A66', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#98C379', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#C678DD', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#56B6C2', bg = 'NONE' })
    local rainbow_delimiters = require 'rainbow-delimiters'
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end,
}
