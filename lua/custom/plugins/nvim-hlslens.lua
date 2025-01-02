return {
  'kevinhwang91/nvim-hlslens',
  event = 'BufRead',
  opts = {},
  config = function()
    require('hlslens').setup {
      calm_down = true,
      nearest_only = true,
    }
  end,
}
