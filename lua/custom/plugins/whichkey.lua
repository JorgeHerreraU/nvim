-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    local wk = require 'which-key'
    wk.add {
      mode = { 'n', 'v' },
      {
        { '<leader>y', icon = { icon = '', color = 'orange' } },
        { '<leader>p', icon = { icon = '', color = 'orange' } },
        { '<leader>x', icon = { icon = '󰅚', color = 'orange' }, desc = 'Close buffer' },
        { '<leader>c', icon = { icon = '󰅙', color = 'orange' }, desc = 'Close other buffers' },
        { '<leader>q', icon = { icon = '󰈆', color = 'orange' }, desc = 'Quit' },
        { '<leader>e', icon = { icon = '󱏒', color = 'orange' }, desc = 'Explorer' },
        { '<leader>z', icon = { icon = '', color = 'orange' } },
        { '<leader>a', group = 'Harvgate', icon = { icon = '󰁤', color = 'grey' }, desc = 'Harvgate' },
        { '<leader>d', group = 'Debug', icon = { icon = '', color = 'grey' } },
        { '<leader>t', group = 'Features', icon = { icon = '', color = 'grey' } },
        { '<leader>f', group = 'Find', icon = { icon = '', color = 'grey' } },
        { '<leader>h', group = 'Git', icon = { icon = '󰊢', color = 'grey' } },
        { '<leader>l', group = 'LSP', icon = { icon = '', color = 'grey' } },
        { '<leader>m', group = 'Testing', icon = { icon = '', color = 'grey' } },
        { '<leader>/', hidden = true },
        { '<leader><leader>', hidden = true },
      },
    }
    wk.setup {
      preset = 'modern',
      win = {
        height = { min = 10, max = 15 },
      },
      layout = {
        width = { min = 40, max = 40 },
        spacing = 6,
      },
      sort = { 'manual' },
    }
  end,
}
