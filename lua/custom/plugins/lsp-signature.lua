return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    opts.hint_prefix = ''
    opts.toggle_key = '<C-k>'
    opts.toggle_key_flip_floatwin_setting = true
    opts.hint_enable = false
    opts.floating_window = false
    require('lsp_signature').setup(opts)
  end,
}
