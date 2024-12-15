return {
  'freddiehaddad/feline.nvim',
  dependencies = {
    'will-lynas/grapple-line.nvim',
  },
  config = function()
    vim.api.nvim_set_hl(0, 'GrappleActive', { fg = '#98c379', bold = true })
    vim.api.nvim_set_hl(0, 'GrappleInactive', { fg = '#6c7380' })

    require('grapple-line').setup {
      colors = {
        active = 'GrappleActive',
        inactive = 'GrappleInactive',
      },
      number_of_files = 4,
      mode = 'unique_filename',
      show_names = false,
      overflow = 'none',
    }
    local function get_spacing()
      if vim.bo.expandtab then
        return 'Spaces: ' .. vim.bo.shiftwidth
      else
        return 'Tab: ' .. vim.bo.tabstop
      end
    end
    require('feline').setup {
      disable = {
        filetypes = {
          'alpha',
        },
      },
      components = {
        active = {
          -- Left side
          {
            {
              provider = function()
                local grapple_line = require('grapple-line').lualine()
                return '󰛢 ' .. (grapple_line or '') -- Always show icon
              end,
              left_sep = ' ',
              right_sep = ' ',
              update = { 'BufEnter', 'User GrappleChanged' },
              hl = {
                fg = 'white', -- for inactive files
                bg = 'NONE',
                active = {
                  fg = '#98c379', -- green color for active file
                  bg = 'NONE',
                  style = 'bold',
                },
              },
            },
            {
              provider = 'git_branch',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
                style = 'bold',
              },
            },
            {
              provider = 'git_diff_added',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
                style = 'bold',
              },
            },
            {
              provider = 'git_diff_removed',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
                style = 'bold',
              },
            },
            {
              provider = 'git_diff_changed',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
                style = 'bold',
              },
            },
            {
              provider = 'diagnostic_errors',
              left_sep = ' ',
              right_sep = '',
              hl = {
                fg = vim.fn.synIDattr(vim.fn.hlID 'DiagnosticError', 'fg'),
                bg = 'NONE',
                style = 'bold',
              },
            },
            {
              provider = 'diagnostic_warnings',
              left_sep = '',
              right_sep = '',
              hl = {
                fg = vim.fn.synIDattr(vim.fn.hlID 'DiagnosticWarn', 'fg'),
                bg = 'NONE',
                style = 'bold',
              },
            },
            {
              provider = 'diagnostic_info',
              left_sep = '',
              right_sep = ' ',
              hl = {
                fg = vim.fn.synIDattr(vim.fn.hlID 'DiagnosticInfo', 'fg'),
                bg = 'NONE',
                style = 'bold',
              },
            },
          },
          -- Middle section
          {
            {
              provider = 'file_info',
              file_modified_icon = '',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
              },
            },
          },
          -- Right side
          {
            {
              provider = 'file_format',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
              },
            },
            {
              provider = 'file_encoding',
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
              },
            },
            {
              provider = get_spacing(),
              left_sep = ' ',
              right_sep = ' ',
              hl = {
                fg = 'white',
                bg = 'NONE',
              },
            },
          },
        },
      },
      theme = {
        bg = 'NONE',
        fg = 'white',
      },
    }
  end,
}
