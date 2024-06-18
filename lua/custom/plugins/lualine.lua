return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      disabled_filetypes = {
        statusline = { 'NvimTree', 'alpha' },
      },
      globalstatus = false,
      component_separator = { left = '', right = '' },
    },
    sections = {
      lualine_x = { 'filetype' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
