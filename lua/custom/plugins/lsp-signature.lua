return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  opts = {
    doc_lines = 0,
    hint_enable = false,
    floating_window = true,
    toggle_key = '<M-k>',
    toggle_key_flip_floatwin_setting = true,
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}
