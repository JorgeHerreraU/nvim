return {
  'mfussenegger/nvim-lint',
  dependencies = {
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'shellcheck',
      },
    }
    require('lint').linters_by_ft = {
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      zsh = { 'shellcheck' },
    }
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
