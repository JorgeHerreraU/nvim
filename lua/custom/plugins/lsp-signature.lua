return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  config = function()
    local cfg = {
      floating_window = false,
      hint_scheme = 'Comment',
      hint_enable = true,
      hint_prefix = {
        above = '↙ ', -- when the hint is on the line above the current line
        current = '← ', -- when the hint is on the same line
        below = '↖ ', -- when the hint is on the line below the current line
      },
    }

    require('lsp_signature').setup(cfg)
  end,
}
