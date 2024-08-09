return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'williamboman/mason.nvim',
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        ensure_installed = {
          'eslint',
        },
      },
    },
  },
  config = function()
    local null_ls = require 'null-ls'
    local eslint_utils = require('null-ls.utils').make_conditional_utils()

    null_ls.setup {
      sources = {
        eslint_utils.root_has_file {
          '.eslintrc.js',
          '.eslintrc.json',
          '.eslintrc',
          '.eslintrc.yml',
          '.eslintrc.yaml',
          'eslint.config.mjs',
        } and require 'none-ls.diagnostics.eslint' or nil,
      },
    }
  end,
}
