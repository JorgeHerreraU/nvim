return {
  'ggandor/leap.nvim',
  enabled = true,
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Forward to' },
    { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap Backward to' },
    { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from Windows' },
  },
  config = function(_, opts)
    local leap = require 'leap'
    leap.opts.safe_labels = {}
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    leap.add_default_mappings(true)
    vim.keymap.del({ 'x', 'o' }, 'x')
    vim.keymap.del({ 'x', 'o' }, 'X')
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#777777' })
  end,
}
