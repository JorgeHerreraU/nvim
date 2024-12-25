return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(buffer)
        local gs = require 'gitsigns'
        vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Git: Restore' })
        vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: Reset Hunk' })
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = 'Git: Preview Hunk' })
        vim.keymap.set('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = 'Git: Blame line' })
        vim.keymap.set('n', '<leader>hB', gs.toggle_current_line_blame, { desc = 'Git: Toggle Blame' })
        vim.keymap.set('n', ']c', function()
          gs.nav_hunk 'next'
        end, { desc = 'Git: Next Hunk' })
        vim.keymap.set('n', '[c', function()
          gs.nav_hunk 'prev'
        end, { desc = 'Git: Previous Hunk' })
        vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Git: Toggle diff' })
      end,
    }
  end,
}
