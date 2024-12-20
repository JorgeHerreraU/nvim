return {
  'stevearc/conform.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- Configure tools based on dotnet availability
    local utils = require 'utils'
    local ensure_installed = {
      'stylua',
      'goimports',
      'prettier',
      'prettierd',
      'shfmt',
      'npm-groovy-lint',
      'ruff',
    }

    if utils.is_dotnet_installed() then
      table.insert(ensure_installed, 'csharpier')
    end

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    -- Configure formatters based on dotnet availability
    local formatters_by_ft = {
      lua = { 'stylua' },
      html = { 'prettier' },
      go = { 'goimports' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      json = { 'prettierd' },
      scss = { 'prettierd' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      groovy = { 'npm-groovy-lint' },
      python = { 'ruff_format' },
    }

    if utils.is_dotnet_installed() then
      formatters_by_ft.cs = { 'csharpier' }
    end

    local conform = require 'conform'

    conform.setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        if #conform.list_formatters(bufnr) == 0 then
          vim.lsp.buf.format {
            timeout_ms = 15000,
            bufnr = bufnr,
          }
          return
        end
        return {
          timeout_ms = 15000,
        }
      end,
      formatters_by_ft = formatters_by_ft,
    }
  end,
}
