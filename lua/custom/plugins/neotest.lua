---@diagnostic disable: missing-fields
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
    'marilari88/neotest-vitest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-dotnet',
        require 'neotest-vitest',
      },
    }
    -- neotest
    vim.api.nvim_set_keymap(
      'n',
      '<leader>mR',
      ':lua require("neotest").run.run({suite = true})<CR>',
      { desc = 'Test: Run All Tests', noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap('n', '<leader>mr', ':lua require("neotest").run.run()<CR>', { desc = 'Test: Run Tests', noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>mt',
      ':lua require("neotest").summary.toggle()<CR>',
      { desc = 'Test: Toggle Test Summary', noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap('n', '<leader>ms', ':lua require("neotest").run.stop()<CR>', { desc = 'Test: Stop Test', noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>mo',
      ':lua require("neotest").output.open({ enter = true })<CR>',
      { desc = 'Test: Open Test Output', noremap = true, silent = true }
    )
  end,
}
