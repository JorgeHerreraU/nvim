return {
  'olimorris/onedarkpro.nvim',
  enabled = false,
  priority = 1000, -- Ensure it loads first
  init = function()
    vim.cmd 'colorscheme onedark'
  end,
}
