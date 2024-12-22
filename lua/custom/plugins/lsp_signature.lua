return {
  'ray-x/lsp_signature.nvim',
  event = 'VeryLazy',
  config = function()
    local function get_win_dim()
      return {
        width = vim.api.nvim_win_get_width(0),
        height = vim.api.nvim_win_get_height(0),
      }
    end

    local cfg = {
      floating_window_off_x = function()
        return get_win_dim().width
      end,

      floating_window_off_y = function()
        return -get_win_dim().height
      end,

      hint_prefix = {
        above = '↙ ', -- when the hint is on the line above the current line
        current = '← ', -- when the hint is on the same line
        below = '↖ ', -- when the hint is on the line below the current line
      },
      doc_lines = 20,
      wrap = true,
      floating_window = false,
      floating_window_above_cur_line = true,
      fix_pos = true,
      hint_scheme = 'Comment',
      hint_enable = true,
      max_width = 60,
      max_height = 80,
      toggle_key = '<M-[>',
      toggle_key_flip_floatwin_setting = true,
      handler_opts = {
        border = 'rounded',
      },
    }

    require('lsp_signature').setup(cfg)
  end,
}
