return {
  'cbochs/grapple.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('grapple').setup {}
    -- Key bindings for tagging and selecting files
    vim.keymap.set('n', '<A-Q>', function()
      require('grapple').tag { index = 1 }
    end, { desc = 'Tag file at index 1' })
    vim.keymap.set('n', '<A-W>', function()
      require('grapple').tag { index = 2 }
    end, { desc = 'Tag file at index 2' })
    vim.keymap.set('n', '<A-E>', function()
      require('grapple').tag { index = 3 }
    end, { desc = 'Tag file at index 3' })
    vim.keymap.set('n', '<A-R>', function()
      require('grapple').tag { index = 4 }
    end, { desc = 'Tag file at index 4' })

    -- Key bindings for selecting tagged files
    vim.keymap.set('n', '<A-q>', function()
      require('grapple').select { index = 1 }
    end, { desc = 'Select tag 1' })
    vim.keymap.set('n', '<A-w>', function()
      require('grapple').select { index = 2 }
    end, { desc = 'Select tag 2' })
    vim.keymap.set('n', '<A-e>', function()
      require('grapple').select { index = 3 }
    end, { desc = 'Select tag 3' })
    vim.keymap.set('n', '<A-r>', function()
      require('grapple').select { index = 4 }
    end, { desc = 'Select tag 4' })

    vim.keymap.set('n', '<leader>o', function()
      require('grapple').tag()
    end, { desc = 'Grapple: Tag current buffer' })
    vim.keymap.set('n', '<leader>O', function()
      require('grapple').reset()
    end, { desc = 'Grapple: Reset' })
  end,
}
