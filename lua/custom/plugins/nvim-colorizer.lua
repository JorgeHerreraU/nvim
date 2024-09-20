return {
  'norcalli/nvim-colorizer.lua',
  enabled = false,
  config = function()
    require('colorizer').setup {
      DEFAULT_OPTIONS = {
        names = false,
      },
    }
  end,
}
