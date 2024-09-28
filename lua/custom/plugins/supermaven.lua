return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<c-y>',
      },
      condition = function()
        vim.defer_fn(function()
          vim.cmd 'echo ""'
          vim.cmd 'redraw'
        end, 50)
        return true
      end,
    }
  end,
}
