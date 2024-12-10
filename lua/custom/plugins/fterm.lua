local utils = require 'utils'
return {
  'numToStr/FTerm.nvim',
  opts = {
    border = 'rounded',
    cmd = utils.is_wsl() and 'zsh' or 'pwsh',
  },
}
