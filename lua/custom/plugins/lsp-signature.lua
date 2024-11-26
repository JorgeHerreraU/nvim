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

      -- Ensure window appears above cursor line
      floating_window_above_cur_line = true,

      -- You might want to adjust these related settings:
      max_width = 80, -- adjust based on your needs
      max_height = 12,
      fix_pos = true, -- set to true to maintain position

      doc_lines = 0,
      hint_enable = false,
      floating_window = true,
      toggle_key = '<M-k>',
      toggle_key_flip_floatwin_setting = true,
    }

    require('lsp_signature').setup(cfg)
  end,
}
