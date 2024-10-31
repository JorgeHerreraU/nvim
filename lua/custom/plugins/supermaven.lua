return {
  'supermaven-inc/supermaven-nvim',
  cmd = { 'SupermavenStart' },
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<c-l>',
      },
    }
  end,
}
