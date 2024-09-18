return {
  'rlane/pounce.nvim',
  config = function()
    local map = vim.keymap.set
    map('n', 's', function()
      require('pounce').pounce {}
    end)
    map('x', 's', function()
      require('pounce').pounce {}
    end)
  end,
}
