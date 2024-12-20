return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/schemastore.nvim',
    'nvim-flutter/flutter-tools.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    { 'seblj/roslyn.nvim', ft = { 'cs', 'axaml.cs' } },
    {
      'folke/lazydev.nvim',
      dependencies = { 'Bilal2453/luvit-meta', lazy = true },
      ft = 'lua',
      opts = { library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } } },
    },
    'nvim-java/nvim-java',
  },

  config = function()
    -- Capabilities
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Handlers
    local handlers = {
      ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
          severity = vim.diagnostic.severity.ERROR,
          spacing = 4,
        },
        signs = true,
        severity_sort = true,
        update_in_insert = false,
      }),
    }

    -- Diagnostics signs
    local signs = {
      { name = 'DiagnosticSignError', text = '' }, -- Replace '!' with your error icon
      { name = 'DiagnosticSignWarn', text = '' }, -- Replace '⚠️' with your warning icon
      { name = 'DiagnosticSignHint', text = '' }, -- Replace '' with your hint icon
      { name = 'DiagnosticSignInfo', text = '' }, -- Replace 'ℹ️' with your info icon
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

    -- Keymaps
    local function setup_lsp_keymaps(bufnr)
      local builtin = require 'telescope.builtin'
      local opts = { buffer = bufnr }

      local function goto_references()
        local params = vim.lsp.util.make_position_params()
        params.context = params.context or {}
        params.context.includeDeclaration = nil
        vim.lsp.buf_request(0, 'textDocument/references', params, function(err, result, _, _)
          if not err and (not result or vim.tbl_isempty(result)) then
            require('telescope.builtin').live_grep {
              default_text = vim.fn.expand '<cword>',
              prompt_title = 'Fallback: Grep Search',
            }
          else
            require('telescope.builtin').lsp_references {
              path_display = { 'smart' },
              show_line = false,
            }
          end
        end)
      end

      local function format_buffer()
        vim.lsp.buf.format { async = true }
      end

      vim.keymap.set('n', 'gd', builtin.lsp_definitions, vim.tbl_extend('force', opts, { desc = 'LSP: Goto Definition' }))
      vim.keymap.set('n', 'gr', goto_references, vim.tbl_extend('force', opts, { desc = 'LSP: Goto References' }))
      vim.keymap.set('n', 'gI', builtin.lsp_implementations, vim.tbl_extend('force', opts, { desc = 'LSP: Goto Implementation' }))
      vim.keymap.set('n', '<leader>lf', format_buffer, vim.tbl_extend('force', opts, { desc = 'LSP: Format buffer' }))
      vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'LSP: Diagnostic messages' }))
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'LSP: Rename' }))
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'LSP: Code Action' }))
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'LSP: Hover Documentation' }))
      vim.keymap.set({ 'i', 'n' }, '<M-k>', vim.lsp.buf.signature_help, { buffer = bufnr })
      vim.keymap.set('v', '<leader>la', function()
        vim.lsp.buf.code_action {
          range = {
            ['start'] = vim.api.nvim_buf_get_mark(0, '<'),
            ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
          },
        }
      end, vim.tbl_extend('force', opts, { desc = 'LSP: Range Code Action' }))
    end

    -- Document highlight
    local function setup_document_highlight(client, bufnr)
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    -- LSP attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-group', { clear = true }),
      callback = function(event)
        setup_lsp_keymaps(event.buf)
        setup_document_highlight(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
      end,
    })

    -- Add semantic tokens support
    -- stylua: ignore
    local tokenTypes = { 'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter', 'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method', 'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator', 'decorator' }
    -- stylua: ignore
    local tokenModifiers = { 'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract', 'async', 'modification', 'documentation', 'defaultLibrary' }
    capabilities.textDocument.semanticTokens = {
      dynamicRegistration = true,
      tokenTypes = tokenTypes,
      tokenModifiers = tokenModifiers,
      formats = { 'relative' },
      requests = {
        range = true,
        full = {
          delta = true,
        },
      },
      overlappingTokenSupport = true,
      multilineTokenSupport = true,
      serverCancelSupport = true,
      augmentsSyntaxTokens = true,
    }

    -- Mason
    require('mason').setup {}
    require('mason-lspconfig').setup {
      ensure_installed = {
        'gopls',
        'lua_ls',
        'html',
        'cssls',
        'angularls',
        'jsonls',
        'vtsls',
        'dockerls',
        'docker_compose_language_service',
        'emmet_language_server',
        'bashls',
        'groovyls',
        'cucumber_language_server',
        'eslint',
        'intelephense',
        'clangd',
        'basedpyright',
      },
    }

    require('java').setup()

    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'

    if not configs.avalonia then
      configs.avalonia = {
        default_config = {
          cmd = { 'dotnet', vim.fn.expand '~/.local/share/avalonia-ls/extension/avaloniaServer/AvaloniaLanguageServer.dll' },
          filetypes = { 'axaml', 'xaml' },
          root_dir = vim.fn.getcwd(),
          settings = {},
        },
      }
    end

    -- lua
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim', 'use' },
            disable = { 'missing-parameter' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    }

    -- jsonls
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      handlers = handlers,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }

    -- golsp
    lspconfig.gopls.setup {
      capabilities = capabilities,
      handlers = handlers,
      cmd = { 'gopls', 'serve' },
      settings = {
        gopls = {
          gofumpt = true,
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }

    -- typescript
    local IGNORED_DIAGNOSTIC_CODES = {
      [80001] = true, -- File is a commonjs module
      [80006] = true, -- This can be converted to an ES module
    }
    lspconfig.vtsls.setup {
      capabilities = capabilities,
      handlers = vim.tbl_extend('force', handlers, {
        ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
          if result.diagnostics then
            result.diagnostics = vim.tbl_filter(function(diagnostic)
              return not IGNORED_DIAGNOSTIC_CODES[diagnostic.code]
            end, result.diagnostics)
          end
          handlers['textDocument/publishDiagnostics'](_, result, ctx, config)
        end,
      }),
      settings = {
        vtsls = {
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
              entriesLimit = 100,
            },
          },
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
        },
        javascript = {
          suggest = {
            enabled = true,
            completeFunctionCalls = true,
            includeCompletionsForImportStatements = true,
            includeAutomaticOptionalChainCompletions = true,
            classMemberSnippets = { enabled = true },
          },
          suggestionActions = { enabled = true },
          preferences = {
            importModuleSpecifierEnding = 'js',
          },
        },
      },
    }

    -- docker
    lspconfig.dockerls.setup {
      capabilities = capabilities,
      handlers = handlers,
    }

    local function set_filetype(pattern, filetype)
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = pattern,
        command = 'set filetype=' .. filetype,
      })
    end

    set_filetype({ 'docker-compose.yml' }, 'yaml.docker-compose')

    lspconfig.docker_compose_language_service.setup {
      capabilities = capabilities,
      handlers = handlers,
    }

    -- css
    lspconfig.cssls.setup {
      capabilities = capabilities,
      handlers = handlers,
      settings = {
        css = {
          lint = {
            unknownAtRules = 'ignore',
          },
        },
      },
    }

    -- csharp
    require('roslyn').setup {
      ---@diagnostic disable-next-line: missing-fields
      config = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        handlers = handlers,
        on_attach = function(client, bufnr)
          vim.lsp.set_log_level 'DEBUG'
          vim.bo[bufnr].tabstop = 4
          vim.bo[bufnr].shiftwidth = 4
          vim.bo[bufnr].expandtab = true
          vim.bo[bufnr].softtabstop = 4
          client.handlers['textDocument/diagnostic'] = vim.lsp.with(vim.lsp.diagnostic.on_diagnostic, {
            virtual_text = { severity = vim.diagnostic.severity.ERROR },
          })
          vim.api.nvim_create_autocmd('BufEnter', {
            buffer = bufnr,
            callback = function()
              vim.lsp.codelens.refresh { bufnr = 0 }
              -- workaround for diagnostics not being triggered
              client.request('textDocument/diagnostic', {
                textDocument = vim.lsp.util.make_text_document_params(),
              }, nil, bufnr)
            end,
          })
        end,
        filewatching = true,
      },
    }

    -- emmet-ls
    lspconfig.emmet_language_server.setup { capabilities = capabilities }

    -- bashls
    lspconfig.bashls.setup {
      capabilities = capabilities,
      handlers = handlers,
      filetypes = { 'sh', 'bash', 'zsh' },
    }

    lspconfig.avalonia.setup {
      capabilities = capabilities,
      handlers = handlers,
      filetypes = { 'axaml', 'xaml' },
    }

    -- dart
    require('flutter-tools').setup {
      lsp = {
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          enableSnippets = true,
          enableSemantic = true,
          analysisExcludedFolders = {
            vim.fn.expand '$HOME/.pub-cache',
            vim.fn.expand '$HOME/fvm',
          },
          completionBudgetMilliseconds = 1000,
          diagnosticsBudgetMilliseconds = 1000,
          navigationBudgetMilliseconds = 1000,
        },
      },
    }

    -- groovy
    lspconfig.groovyls.setup {
      capabilities = capabilities,
      handlers = handlers,
    }

    -- cucumber
    lspconfig.cucumber_language_server.setup {
      capabilities = capabilities,
      handlers = handlers,
    }

    -- java
    lspconfig.jdtls.setup {}

    -- eslint
    lspconfig.eslint.setup {
      handlers = handlers,
      capabilities = capabilities,
    }

    -- php
    lspconfig.intelephense.setup {
      handlers = handlers,
      capabilities = capabilities,
    }

    --clangd
    lspconfig.clangd.setup {
      handlers = handlers,
      capabilities = capabilities,
    }

    -- python
    lspconfig.basedpyright.setup {
      handlers = handlers,
      capabilities = capabilities,
    }
  end,
}
