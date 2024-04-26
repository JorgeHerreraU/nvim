return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local logo = {
      [[ ███       ███ ]],
      [[████      ████]],
      [[██████     █████]],
      [[███████    █████]],
      [[████████   █████]],
      [[█████████  █████]],
      [[█████ ████ █████]],
      [[█████  █████████]],
      [[█████   ████████]],
      [[█████    ███████]],
      [[█████     ██████]],
      [[████      ████]],
      [[ ███       ███ ]],
      [[                  ]],
      [[ N  E  O  V  I  M ]],
    }
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    dashboard.section.header.val = logo
    -- Define 'AlphaNeovimLogoBlue'
    vim.api.nvim_set_hl(0, 'AlphaNeovimLogoBlue', { fg = '#86a5e2', bg = 'NONE', bold = true })

    -- Define 'AlphaNeovimLogoGreen'
    vim.api.nvim_set_hl(0, 'AlphaNeovimLogoGreen', { fg = '#a4d09b', bg = 'NONE', bold = true })

    -- Define 'AlphaNeovimLogoGreenFBlueB'
    vim.api.nvim_set_hl(0, 'AlphaNeovimLogoGreenFBlueB', { fg = '#a4d09b', bg = '#86a5e2', bold = true })

    -- Define 'AlphaNeovimLogoLightGreen'
    vim.api.nvim_set_hl(0, 'AlphaNeovimLogoLightGreen', { fg = '#51664c', bg = 'NONE', bold = false })

    dashboard.section.header.opts.hl = {
      {
        { 'AlphaNeovimLogoBlue', 0, 0 },
        { 'AlphaNeovimLogoGreen', 1, 16 },
        { 'AlphaNeovimLogoBlue', 23, 35 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 4 },
        { 'AlphaNeovimLogoGreenFBlueB', 4, 6 },
        { 'AlphaNeovimLogoGreen', 6, 21 },
        { 'AlphaNeovimLogoBlue', 27, 42 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 6 },
        { 'AlphaNeovimLogoGreenFBlueB', 6, 9 },
        { 'AlphaNeovimLogoGreen', 9, 24 },
        { 'AlphaNeovimLogoBlue', 29, 44 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 11 },
        { 'AlphaNeovimLogoGreenFBlueB', 11, 13 },
        { 'AlphaNeovimLogoGreen', 13, 27 },
        { 'AlphaNeovimLogoBlue', 31, 46 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 14 },
        { 'AlphaNeovimLogoGreenFBlueB', 14, 18 },
        { 'AlphaNeovimLogoGreen', 18, 30 },
        { 'AlphaNeovimLogoBlue', 33, 48 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 16, 33 },
        { 'AlphaNeovimLogoBlue', 35, 51 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 18, 34 },
        { 'AlphaNeovimLogoBlue', 35, 51 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 18, 35 },
        { 'AlphaNeovimLogoBlue', 35, 51 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 18, 36 },
        { 'AlphaNeovimLogoGreenFBlueB', 35, 37 },
        { 'AlphaNeovimLogoBlue', 37, 51 },
        { 'AlphaNeovimLogoLightGreen', 52, 100 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 19, 37 },
        { 'AlphaNeovimLogoGreenFBlueB', 36, 37 },
        { 'AlphaNeovimLogoBlue', 37, 46 },
        { 'AlphaNeovimLogoLightGreen', 47, 100 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 20, 38 },
        { 'AlphaNeovimLogoGreenFBlueB', 37, 39 },
        { 'AlphaNeovimLogoBlue', 39, 45 },
        { 'AlphaNeovimLogoLightGreen', 46, 100 },
      },
      {
        { 'AlphaNeovimLogoBlue', 0, 15 },
        { 'AlphaNeovimLogoGreen', 21, 39 },
        { 'AlphaNeovimLogoGreenFBlueB', 38, 39 },
        { 'AlphaNeovimLogoBlue', 39, 45 },
        { 'AlphaNeovimLogoLightGreen', 45, 100 },
      },
      {
        { 'AlphaNeovimLogoBlue', 1, 13 },
        { 'AlphaNeovimLogoGreen', 20, 35 },
        { 'AlphaNeovimLogoLightGreen', 36, 100 },
      },
      {},
      { { 'AlphaNeovimLogoGreen', 0, 9 }, { 'AlphaNeovimLogoBlue', 9, 18 } },
    }
    alpha.setup(dashboard.opts)
  end,
}
