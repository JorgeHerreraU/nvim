return {
  enabled = false,
  'dgox16/oldworld.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('oldworld').setup {
      integrations = {
        neo_tree = true,
      },
    }
    vim.cmd.colorscheme 'oldworld'
  end,
}
