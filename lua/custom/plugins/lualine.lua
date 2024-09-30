return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    {
      'will-lynas/grapple-line.nvim',
      version = '1.x',
      opts = {
        colors = {
          active = 'Special',
          inactive = 'SpecialComment',
        },
      },
    },
  },
  config = function()
    local utils = require 'utils'
    local custom_theme = require 'lualine.themes.auto'
    -- Function to recursively set background to 'none'
    local function set_bg_none(tbl)
      for k, v in pairs(tbl) do
        if type(v) == 'table' then
          if k ~= 'a' and v.bg then
            v.bg = 'none'
          end
          set_bg_none(v)
        end
      end
    end
    -- Line endings
    local function line_ending()
      local format = vim.bo.fileformat
      local symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' }
      return symbols[format] or format
    end
    -- Spacing info
    local function spacing_info()
      if vim.bo.expandtab then
        return 'Spaces: ' .. vim.bo.shiftwidth
      else
        return 'Tabs: ' .. vim.bo.tabstop
      end
    end
    -- Buffers
    local function buffer_list()
      local output = {}
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      local current = vim.fn.bufnr '%'
      for i, buf in ipairs(buffers) do
        if buf.bufnr == current then
          table.insert(output, string.format('[%d]', i))
        else
          table.insert(output, tostring(i))
        end
      end
      return table.concat(output, ' ')
    end
    -- Function signature
    local current_signature = function(width)
      local sig = require('lsp_signature').status_line(width)
      if not sig.label or sig.label == '' then
        return ''
      end

      -- Find the position of the first '('
      local start_pos = sig.label:find '%('
      if start_pos then
        -- Return everything from '(' onwards
        return '󰊕' .. sig.label:sub(start_pos)
      else
        return ''
      end
    end
    -- Search custom
    local search_custom = function()
      local search = vim.fn.searchcount()
      if search.total > 0 and vim.v.hlsearch == 1 then
        return ' ' .. search.current .. '/' .. search.total
      else
        return ''
      end
    end

    -- Apply transparent background to all theme sections
    set_bg_none(custom_theme)
    require('lualine').setup {
      options = {
        theme = custom_theme,
        globalstatus = false,
        disabled_filetypes = {
          statusline = { 'NvimTree', 'alpha', 'dap-repl', 'dapui_console', 'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes' },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = {
          require('grapple-line').lualine,
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = '󰝶 ',
            },
            separator = '',
            padding = { right = 3 },
          },
          {
            search_custom,
            color = { fg = utils.get_hlgroup('Function').fg },
            padding = { right = 3 },
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = utils.get_hlgroup 'String',
          },
          {
            'diff',
            separator = { left = '' },
            color = { bg = 'none' },
          },
        },
        lualine_y = {},
        lualine_z = {
          {
            line_ending,
            separator = { left = '', right = '' },
            color = utils.get_hlgroup 'String',
          },
          {
            spacing_info,
            separator = { left = '', right = '' },
            color = utils.get_hlgroup 'Comment',
          },
          {
            'encoding',
            color = { fg = utils.get_hlgroup('Function').fg, bg = 'none' },
          },
          {
            function()
              return ''
            end,
            color = { fg = '#008000', bg = 'none' },
          },
        },
      },
      extensions = { 'lazy', 'toggleterm', 'mason' },
    }
  end,
}
