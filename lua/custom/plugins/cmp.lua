return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'Exafunction/codeium.nvim',
      cmd = 'Codeium',
      build = ':Codeium Auth',
      opts = {},
    },
    -- luasnip
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
      },
    },
    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    -- lsp icons
    'onsails/lspkind.nvim',
  },
  config = function()
    -- See `:help cmp`
    require('codeium').setup {}
    require('luasnip.loaders.from_vscode').lazy_load()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local utils = require 'utils'
    -- Register sources
    local sources = {
      { name = 'nvim_lsp' },
      { name = 'codeium' },
      { name = 'luasnip' },
      { name = 'path' },
      {
        name = 'html-css',
        option = {
          enable_on = {
            'html',
            'javascript',
            'typescriptreact',
          },
          file_extensions = { 'css', 'sass', 'less' },
          style_sheets = {
            -- example of remote styles, only css no js for now
            'https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css',
          },
        },
      },
    }
    -- Pass sources to utils setup for additional resources configuration
    utils.setup_cmp_sources(sources)
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
          col_offset = -3,
          side_padding = 0,
        },
        documentation = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
        },
      },

      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local lspkind = require 'lspkind'
          local kind = lspkind.cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, vim_item)
          local strings = vim.split(kind.kind, '%s', { trimempty = true })

          if entry.source.name == 'codeium' then
            kind.kind = ' 󰘦'
            kind.menu = '    (Codeium)'
            vim.cmd [[highlight CustomCmpCodeium guifg=#A08DBF]]
            kind.kind_hl_group = 'CustomCmpCodeium'
          else
            kind.kind = ' ' .. (strings[1] or '') .. ' '
            kind.menu = '    (' .. (strings[2] or '') .. ')'
          end

          return kind
        end,
      },
      preselect = 'None',
      completion = { completeopt = 'menu,menuone,noinsert,noselect' },
      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},
        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { 'i', 's' }),
        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = cmp.config.sources(sources),
    }
  end,
}
