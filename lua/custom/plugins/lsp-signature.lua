return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  config = function()
    local cfg = {
      floating_window = false,
      hint_inline = function()
        return true
      end,
      hint_prefix = '',
      hint_scheme = 'Comment',
    }

    require('lsp_signature').setup(cfg)
  end,
}
