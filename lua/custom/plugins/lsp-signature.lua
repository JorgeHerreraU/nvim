return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  config = function()
    local cfg = {
      doc_lines = 0,
      hint_enable = true,
      hint_scheme = 'Comment',
      hint_prefix = {
        above = '↙ ', -- when the hint is on the line above the current line
        current = '← ', -- when the hint is on the same line
        below = '↖ ', -- when the hint is on the line below the current line
      },
      max_height = 3,
      max_width = 60,
      toggle_key = '<M-k>',
      toggle_key_flip_floatwin_setting = true,
    }

    require('lsp_signature').setup(cfg)
  end,
}
