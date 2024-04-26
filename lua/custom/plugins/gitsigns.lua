-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { hl = 'GitSignsAdd', text = '+' },
      change = { hl = 'GitSignsChange', text = '~' },
      delete = { hl = 'GitSignsDelete', text = '_' },
      topdelete = { hl = 'GitSignsTopDelete', text = 'ΓÇ╛' },
      changedelete = { hl = 'GitSignsChangeDelete', text = '~' },
    },
  },
}
