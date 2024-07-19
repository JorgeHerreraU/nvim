return {
  'stevearc/conform.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        ensure_installed = {
          'stylua',
          'goimports',
          'csharpier',
          'prettier',
          'prettierd',
        },
      },
    },
  },
  config = function()
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        -- local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          -- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      ---@type nil|table<string, conform.FiletypeFormatter>
      formatters_by_ft = {
        lua = { 'stylua' },
        cs = { 'csharpier' },
        html = { 'prettier' },
        go = { 'goimports' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        json = { 'prettierd' },
        scss = { 'prettierd' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    }
  end,
}
