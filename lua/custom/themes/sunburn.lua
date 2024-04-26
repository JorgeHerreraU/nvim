return {
  'loganswartz/sunburn.nvim',
  enabled = false,
  dependencies = { 'loganswartz/polychrome.nvim' },
  -- you could do this, or use the standard vimscript `colorscheme sunburn`
  config = function()
    vim.cmd.colorscheme 'sunburn'
  end,
}
