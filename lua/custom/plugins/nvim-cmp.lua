return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  enabled = true,
  dependencies = {
    -- luasnip
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      dependencies = {
        'saadparwaiz1/cmp_luasnip',
      },
      build = 'make install_jsregexp',
    },
    { 'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter' },
    { 'hrsh7th/cmp-path', event = 'InsertEnter' },
    { 'hrsh7th/cmp-cmdline', event = 'CmdlineEnter' },
    { 'onsails/lspkind.nvim', event = 'InsertEnter' },
  },
  config = function()
    local cmp = require 'cmp'
    -- Luasnip
    local luasnip = require 'luasnip'
    luasnip.cleanup()
    luasnip.config.setup { enable_autosnippets = true }
    local snippets_path = vim.fn.stdpath 'config' .. '/lua/custom/snippets'
    require('luasnip.loaders.from_lua').load { paths = { snippets_path } }

    -- CMD
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },
      }),
    })

    -- Keymaps
    local keybinds = {
      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don't need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      ['<C-Space>'] = cmp.mapping.complete {},
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
      -- Enter key
      ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm { select = true }
        else
          fallback()
        end
      end, { 'i', 's' }),
      -- Tab key
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { select = true }
        else
          fallback()
        end
      end, { 'i', 's' }),
      -- Select first snippet
      ['<C-k>'] = cmp.mapping(function()
        if cmp.visible() then
          local entries = cmp.get_entries()
          for i, entry in ipairs(entries) do
            if entry.source.name == 'luasnip' then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select, count = 1 }
              for _ = 2, i do
                cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
              end
              cmp.confirm { select = true }
              return
            end
          end
        end
      end, { 'i', 's' }),
      -- Move across snippets
      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
      ['<C-l>'] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    }

    -- Register sources
    local sources = {
      { name = 'lazydev', group_index = 0 },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    }

    local formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, item)
        local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50 }(entry, item)
        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        kind.kind = ' ' .. (strings[1] or '') .. ' '
        kind.menu = '    (' .. (strings[2] or '') .. ')'

        return kind
      end,
    }

    -- Config
    local config = {
      sources = cmp.config.sources(sources),
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = 'None',
      completion = { completeopt = 'menu,menuone,noinsert,noselect' },
      mapping = cmp.mapping.preset.insert(keybinds),
      window = {
        completion = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
          col_offset = -3,
          side_padding = 0,
          scrollbar = false,
        },
        documentation = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
        },
      },
      formatting = formatting,
    }

    cmp.setup(config)
  end,
}
