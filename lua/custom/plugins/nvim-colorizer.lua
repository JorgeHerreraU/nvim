return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup {
      DEFAULT_OPTIONS = {
        names = false,
      },
    }
  end,
}
