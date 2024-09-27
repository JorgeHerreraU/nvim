return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<c-y>',
      },
      condition = function()
        return true
      end,
    }
  end,
}
