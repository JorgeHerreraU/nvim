return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  enabled = true,
  config = function()
    local M = {}

    local mode_width = 0
    local branch_width = 0
    local diff_width = 0
    local filetype_width = 0
    local filename_width = 0

    local function line_ending()
      local format = vim.bo.fileformat
      local symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' }
      return symbols[format] or format
    end

    local function spacing_info()
      if vim.bo.expandtab then
        return 'Spaces: ' .. vim.bo.shiftwidth
      else
        return 'Tabs: ' .. vim.bo.tabstop
      end
    end

    M.sections = {
      lualine_a = {
        {
          'grapple',
          fmt = function(str)
            if str == '' or not str then
              mode_width = 0
              return ''
            end

            local str_value = tostring(str)
            local display_width = vim.fn.strdisplaywidth(str_value)

            mode_width = display_width + 2
            return str_value
          end,
        },
      },
      lualine_b = {
        {
          'branch',
          cond = function()
            local should_show = vim.opt.columns:get() > 60
            if not should_show then
              branch_width = 0
            end
            return should_show
          end,
          fmt = function(str)
            if str == '' then
              branch_width = 0
              return ''
            end
            branch_width = #str + 2 + 2
            return str
          end,
        },
        {
          'diff',
          cond = function()
            local should_show = vim.opt.columns:get() > 60
            if not should_show then
              diff_width = 0
            end
            return should_show
          end,
          fmt = function(str)
            if str == '' then
              diff_width = 0
              return ''
            end
            local evaled_str = vim.api.nvim_eval_statusline(str, {}).str
            diff_width = #evaled_str + 2
            return str
          end,
        },
      },
      lualine_c = {
        {
          function()
            local used_space = mode_width + branch_width + diff_width
            local win_width = vim.opt.columns:get()
            local fill_space = string.rep(' ', math.floor((win_width - filename_width - filetype_width) / 2) - used_space)
            return fill_space
          end,
          padding = { left = 0, right = 0 },
          cond = function()
            return vim.opt.columns:get() > 60
          end,
        },
        {
          'filetype',
          fmt = function(str)
            if str == '' then
              filetype_width = 0
              return ''
            end
            filetype_width = 1 + 2
            return str
          end,
          icon_only = true,
        },
        {
          'filename',
          fmt = function(filename)
            if filename == '' then
              filename_width = 0
              return ''
            end

            local used_space = mode_width + branch_width + diff_width
            local win_width = vim.opt.columns:get()
            local free_space = (math.floor(win_width / 2) - used_space) * 2

            if free_space < #filename + filetype_width + 10 then
              filename = vim.fn.expand '%:t'
            end

            if free_space < #filename + filetype_width + 10 then
              local end_idx = free_space - filetype_width - 13
              if end_idx < 0 then
                return ''
              end
              filename = string.sub(filename, 1, end_idx) .. '...'
            end

            filename_width = #filename + 2

            return filename
          end,
          file_status = true,
          newfile_status = false,
          path = 0,
          shorting_target = 0,
          symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
        },
      },
      lualine_x = {
        { 'diagnostics' },
      },
      lualine_y = {
        {
          'encoding',
          cond = function()
            return vim.opt.columns:get() > 80
          end,
        },
      },
      lualine_z = {
        {
          line_ending,
          padding = { left = 1, right = 0 },
        },
        spacing_info,
      },
    }

    require('lualine').setup {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {
            'NvimTree',
            'alpha',
            'dap-repl',
            'dapui_console',
            'dapui_watches',
            'dapui_stacks',
            'dapui_breakpoints',
            'dapui_scopes',
            'leetcode.nvim',
          },
        },
        theme = {
          normal = {
            a = { bg = 'NONE' },
            b = { bg = 'NONE' },
            c = { bg = 'NONE' },
            x = { bg = 'NONE' },
            y = { bg = 'NONE' },
            z = { bg = 'NONE' },
          },
          insert = {
            a = { bg = 'NONE' },
            b = { bg = 'NONE' },
            c = { bg = 'NONE' },
            x = { bg = 'NONE' },
            y = { bg = 'NONE' },
            z = { bg = 'NONE' },
          },
          visual = {
            a = { bg = 'NONE' },
            b = { bg = 'NONE' },
            c = { bg = 'NONE' },
            x = { bg = 'NONE' },
            y = { bg = 'NONE' },
            z = { bg = 'NONE' },
          },
          replace = {
            a = { bg = 'NONE' },
            b = { bg = 'NONE' },
            c = { bg = 'NONE' },
            x = { bg = 'NONE' },
            y = { bg = 'NONE' },
            z = { bg = 'NONE' },
          },
          command = {
            a = { bg = 'NONE' },
            b = { bg = 'NONE' },
            c = { bg = 'NONE' },
            x = { bg = 'NONE' },
            y = { bg = 'NONE' },
            z = { bg = 'NONE' },
          },
          inactive = {
            a = { bg = 'NONE' },
            b = { bg = 'NONE' },
            c = { bg = 'NONE' },
            x = { bg = 'NONE' },
            y = { bg = 'NONE' },
            z = { bg = 'NONE' },
          },
        },
      },
      sections = M.sections,
    }
  end,
}
