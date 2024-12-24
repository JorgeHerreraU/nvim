return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = false,
  config = function()
    require('refactoring').setup {}
    vim.keymap.set('x', '<leader>re', ':Refactor extract ', { desc = 'Refactor extract' })
    vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ', { desc = 'Refactor extract to file' })
    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ', { desc = 'Refactor extract var' })
    vim.keymap.set('n', '<leader>rI', ':Refactor inline_func', { desc = 'Refactor inline func' })
    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block', { desc = 'Refactor extract block' })
    vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file', { desc = 'Refactor extract block to file' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var', { desc = 'Refactor inline var' })
  end,
}
