return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    -- This module contains a number of default definitions
    local rainbow_delimiters = require 'rainbow-delimiters'

    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      blacklist = {
        'tsx',
      },
      highlight = {
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
