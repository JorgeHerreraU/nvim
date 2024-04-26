--[[
     .,o'       `o,.
   ,o8'           `8o.
  o8'               `8o
 o8:                 ;8o
.88                   88.
:88.                 ,88:
`888                 888'
 888o   `888 888'   o888
 `888o,. `88 88' .,o888'
  `8888888888888888888'
    `888888888888888'
       `::88;88;:'
          88 88
          88 88
          `8 8'
           ` ' 

Kickstart.nvim Configuration

Kickstart.nvim is a foundation for personal Neovim configuration, designed to be clear and modifiable.

- Start with `:Tutor` to learn Neovim basics.
- Explore and modify the code to understand and tailor it to your needs.
- Use `:help` and `<space>sh` to access and search Neovim's documentation.
- Add your plugins and configurations in `lua/custom/plugins/*.lua`.
- For errors or checks, use `:checkhealth`.

See https://learnxinyminutes.com/docs/lua/ for a Lua primer.
Refer to https://neovim.io/doc/user/lua-guide.html for Neovim's Lua integration.

]]

-- Load basic configurations
require 'settings' -- Load basic settings
require 'keybindings' -- Load key mappings
require 'autocmds' -- Load autocommands
-- Plugin management with `lazy.nvim`
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  {
    'zapling/mason-lock.nvim',
    init = function()
      require('mason-lock').setup {
        lockfile_path = vim.fn.stdpath 'config' .. '/mason-lock.json', -- (default)
      }
    end,
  },
  { import = 'custom.plugins' },
  { import = 'custom.themes' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
-- ftplugin
vim.cmd [[filetype plugin on]]
