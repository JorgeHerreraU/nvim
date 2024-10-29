return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
    -- json
    'b0o/schemastore.nvim',
    -- lua
    {
      'folke/lazydev.nvim',
      dependencies = {
        { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
      },
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    -- csharp
    {
      'Hoffs/omnisharp-extended-lsp.nvim',
      ft = 'cs',
    },
  },

  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach-group', { clear = true }),
      callback = function(event)
        -- keybindings

        vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, {
          buffer = event.buf,
          desc = 'LSP: Goto Definition',
        })

        vim.keymap.set('n', 'gr', function()
          require('telescope.builtin').lsp_references {
            path_display = { 'smart' },
            show_line = false,
          }
        end, {
          buffer = event.buf,
          desc = 'LSP: Goto References',
        })

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, {
          buffer = event.buf,
          desc = 'LSP: Goto Implementation',
        })

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        -- vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_type_definitions, {
        --   buffer = event.buf,
        --   desc = 'LSP: Type Definition'
        -- })

        vim.keymap.set('n', '<leader>lf', function()
          vim.lsp.buf.format { async = true }
        end, {
          buffer = event.buf,
          desc = 'LSP: Format buffer',
        })

        -- Show diagnostic message
        vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, {
          buffer = event.buf,
          desc = 'LSP: Diagnostic messages',
        })

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        -- vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, {
        --   buffer = event.buf,
        --   desc = 'LSP: Document Symbols'
        -- })

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        -- vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, {
        --   buffer = event.buf,
        --   desc = 'LSP: Workspace Symbols'
        -- })

        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {
          buffer = event.buf,
          desc = 'LSP: Rename',
        })

        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {
          buffer = event.buf,
          desc = 'LSP: Code Action',
        })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
          buffer = event.buf,
          desc = 'LSP: Hover Documentation',
        })

        -- This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
        --   buffer = event.buf,
        --   desc = 'LSP: Goto Declaration'
        -- })

        -- Highlight word under cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local handlers = {
      ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = { severity = vim.diagnostic.severity.ERROR },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = { severity = { min = vim.diagnostic.severity.INFO } },
      }),
    }

    local signs = {
      { name = 'DiagnosticSignError', text = '' }, -- Replace '!' with your error icon
      { name = 'DiagnosticSignWarn', text = '' }, -- Replace '⚠️' with your warning icon
      { name = 'DiagnosticSignHint', text = '' }, -- Replace '' with your hint icon
      { name = 'DiagnosticSignInfo', text = '󰋽' }, -- Replace 'ℹ️' with your info icon
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
    end

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
        'omnisharp',
      },
    }

    local lspconfig = require 'lspconfig'

    -- lua
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      handlers = handlers,
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

    -- emmet-ls
    lspconfig.emmet_language_server.setup { capabilities = capabilities }

    -- omnisharp
    lspconfig.omnisharp.setup {
      capabilities = capabilities,
      handlers = handlers,
      settings = {
        RoslynExtensionsOptions = {
          EnableImportCompletion = true,
        },
      },
      on_attach = function(client, bufnr)
        vim.bo[bufnr].shiftwidth = 4
        vim.bo[bufnr].tabstop = 4
        vim.bo[bufnr].expandtab = true
        -- set go to definition keybinding for omnisharp
        vim.keymap.set('n', 'gd', function()
          require('omnisharp_extended').telescope_lsp_definitions {}
        end, {
          buffer = bufnr,
          desc = 'LSP: Goto Definition',
        })
      end,
    }
  end,
}
