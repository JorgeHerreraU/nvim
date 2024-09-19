---@diagnostic disable: missing-fields
-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    {
      'folke/neodev.nvim',
      opts = {
        library = { plugins = { 'nvim-dap-ui' }, types = true },
      },
    },
  },
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local dap = require 'dap'
    local dapui

    local function setup_dapui()
      if not dapui then
        dapui = require 'dapui'
        dapui.setup {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = { enabled = true },
          layouts = {
            {
              elements = {
                { id = 'scopes', size = 0.60 },
                { id = 'breakpoints', size = 0.20 },
                { id = 'watches', size = 0.20 },
              },
              position = 'left',
              size = 40,
            },
          },
        }
      end
    end

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'coreclr',
        'delve',
        'js',
      },
    }

    -- Keymaps helper functions
    local breakpoint_condition = function()
      dap.set_breakpoint(vim.fn.ibput 'Debug: Breakpoint Condition: ')
    end
    local toggle_dap_ui = function()
      setup_dapui()
      dapui.toggle()
    end
    -- Keymaps
    vim.keymap.set('n', '<leader>bc', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>bn', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>bs', dap.close, { desc = 'Debug: Stop' })
    vim.keymap.set('n', '<leader>bt', dap.terminate, { desc = 'Debug: Terminate' })
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>bB', breakpoint_condition, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>bi', toggle_dap_ui, { desc = 'Debug: Toggle Interface' })

    -- Debuggers Setup
    -- c#
    dap.adapters.coreclr = {
      type = 'executable',
      command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
      args = { '--interpreter=vscode' },
      options = {
        detached = false,
      },
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'console - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Entry point: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
      {
        type = 'coreclr',
        name = 'aspnetcore - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Entry Point: ', vim.fn.getcwd() .. '/', 'file')
        end,
        env = {
          ASPNETCORE_ENVIRONMENT = function()
            -- todo: request input from ui
            return 'Development'
          end,
          ASPNETCORE_URLS = function()
            -- todo: request input from ui
            return 'http://localhost:5283'
          end,
        },
        cwd = function()
          return vim.fn.input('appsettings.json: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }

    -- go
    dap.adapters.go = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
      },
    }

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
      },
      {
        type = 'go',
        name = 'Debug test', -- configuration for debugging test files
        request = 'launch',
        mode = 'test',
        program = '${file}',
      },

      {
        type = 'go',
        name = 'Debug test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
      },
    }

    -- typescript
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = {
          '${port}',
        },
      },
    }
    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch TypeScript File (ts-node installed locally)',
        runtimeArgs = { '--require', 'ts-node/register' },
        runtimeExecutable = 'node',
        args = { '${file}' },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/.pnpm/**',
        },
      },
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch TypeScript File (tsx installed locally)',
        runtimeExecutable = '${workspaceFolder}/node_modules/.bin/tsx',
        args = { '${file}' },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/.pnpm/**',
        },
      },
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch TypeScript File (swc-node installed locally)',
        runtimeExecutable = 'node',
        runtimeArgs = { '--require', '@swc-node/register' },
        args = { '${file}' },
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/.pnpm/**',
        },
      },
    }

    vim.fn.sign_define('DapBreakpoint', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = 'DapBreakpoint',
    })

    vim.fn.sign_define('DapBreakpointRejected', {
      text = '',
      texthl = 'DapBreakpoint',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    })

    vim.fn.sign_define('DapLogPoint', {
      text = '',
      texthl = 'DapLogPoint',
      linehl = 'DapLogPoint',
      numhl = 'DapLogPoint',
    })

    vim.fn.sign_define('DapStopped', {
      text = '',
      texthl = 'DapStopped',
      linehl = 'DapStopped',
      numhl = 'DapStopped',
    })

    -- DAP UI open/close based on events
    dap.listeners.after.event_initialized['dapui_config'] = function()
      setup_dapui()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      if dapui then
        dapui.close()
      end
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      if dapui then
        dapui.close()
      end
    end
  end,
}
