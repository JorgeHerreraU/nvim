return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    } },
    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { 'folke/neodev.nvim', opts = {} },
    -- omnisharp (go-to definitions)
    'Hoffs/omnisharp-extended-lsp.nvim',
    -- 'Decodetalkers/csharpls-extended-lsp.nvim',
    -- rust
    {
      'simrat39/rust-tools.nvim',
      ft = 'rust',
      dependencies = { 'neovim/nvim-lspconfig' },
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
        -- local function to make keybindings mapping easier
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- NOTE: ftplugin overrides go-to-definition keybinding
        local buffer_filetype = vim.api.nvim_get_option_value('filetype', { buf = event.buf })
        if buffer_filetype ~= 'cs' and buffer_filetype ~= 'java' then -- Skip for filetypes
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        end

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, 'Goto References')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        -- map('<leader>ld', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Show diagnostic message
        map('<leader>ld', vim.diagnostic.open_float, 'Diagnostic messages')
        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>lr', vim.lsp.buf.rename, 'Rename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>la', vim.lsp.buf.code_action, 'Code Action')

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.

        -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
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
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local handlers = {
      -- Buffer diagnostics
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
    -- lsp installation list
    require('mason-lspconfig').setup {
      ensure_installed = {
        'gopls',
        'lua_ls',
        'html',
        'cssls',
        'angularls',
        'jdtls',
        'jsonls',
        'rust_analyzer',
        'vtsls',
        'dockerls',
        'docker_compose_language_service',
        'omnisharp',
      },
    }
    -- LSP servers configuration

    -- lua
    require('lspconfig').lua_ls.setup {
      capabilities = capabilities,
    }

    -- jsonls
    require('lspconfig').jsonls.setup {
      capabilities = capabilities,
    }

    -- golsp
    require('lspconfig').gopls.setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
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

    -- omnisharp
    require('lspconfig').omnisharp.setup {
      capabilities = capabilities,
      settings = {
        RoslynExtensionsOptions = {
          EnableImportCompletion = true,
        },
      },
    }

    -- typescript
    require('lspconfig').vtsls.setup {
      capabilities = capabilities,
      handlers = {
        ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
          if result.diagnostics ~= nil then
            local idx = 1
            while idx <= #result.diagnostics do
              -- 8001 File is a commonjs module
              if result.diagnostics[idx].code == 80001 then
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end
          end
          vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
      },
      on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
      settings = {
        typescript = {
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
        javascript = {
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = 'literals' },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
        vtsls = {
          experimental = {
            maxInlayHintLength = 25,
          },
        },
      },
    }

    -- css
    require('lspconfig').cssls.setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
    }

    -- rust
    require('rust-tools').setup {
      server = {
        on_attach = function(client, bufnr) end,
        handlers = handlers,
        capabilities = capabilities,
      },
    }

    -- docker
    require('lspconfig').dockerls.setup {
      capabilities = capabilities,
    }
    local function set_filetype(pattern, filetype)
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = pattern,
        command = 'set filetype=' .. filetype,
      })
    end

    set_filetype({ 'docker-compose.yml' }, 'yaml.docker-compose')
    require('lspconfig').docker_compose_language_service.setup {
      capabilities = capabilities,
    }
  end,
}
