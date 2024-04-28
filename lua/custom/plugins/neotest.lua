return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
  },
  config = function()
    require('neotest').setup {
      adapters = { require 'neotest-dotnet' },
    }
    -- neotest
    vim.api.nvim_set_keymap('n', '<leader>mR', ':lua require("neotest").run.run({suite = true})<CR>', { desc = 'Run All Tests', noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>mr', ':lua require("neotest").run.run()<CR>', { desc = 'Run Tests', noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>mt', ':lua require("neotest").summary.toggle()<CR>', { desc = 'Toggle Test Summary', noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ms', ':lua require("neotest").run.stop()<CR>', { desc = 'Stop Test', noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>mo',
      ':lua require("neotest").output.open({ enter = true })<CR>',
      { desc = 'Open Test Output', noremap = true, silent = true }
    )
  end,
}
