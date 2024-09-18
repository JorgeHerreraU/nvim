-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local function map(mode, lhs, rhs, opts)
          opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
        local wk = require 'which-key'
        wk.add({
          -- Actions
          { '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>', desc = 'Stage hunk', mode = { 'n', 'v' } },
          { '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', desc = 'Reset hunk', mode = { 'n', 'v' } },
          { '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', desc = 'Stage buffer' },
          { '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', desc = 'Undo stage hunk' },
          { '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', desc = 'Reset buffer' },
          { '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', desc = 'Preview hunk' },
          { '<leader>hb', '<cmd>Gitsigns blame_line{full=true}<CR>', desc = 'Blame line' },
          { '<leader>hB', '<cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'Toggle line blame' },
          { '<leader>hd', "<cmd>lua require('gitsigns').diffthis() vim.api.nvim_command('wincmd h')<CR>", desc = 'Diff view' },
        }, { buffer = bufnr })
      end,
    }
  end,
}
