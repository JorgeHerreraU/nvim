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
    local cmp = require 'cmp'
    local utils = require 'utils'
    -- Register sources
    local sources = {
      { name = 'nvim_lsp' },
      { name = 'codeium' },
      { name = 'path' },
    }
    -- Pass sources to utils setup for additional resources configuration
    utils.setup_cmp_sources(sources)
    cmp.setup {
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = function(entry, vim_item)
          local lspkind = require 'lspkind'

          vim.cmd [[ 
            highlight CustomCmpCodeium guifg=#E0AF68
            
          ]]

          local menus = {
            buffer = '[buf]',
            codeium = '[Codeium]',
            nvim_lsp = '[LSP]',
            path = '[path]',
            nvim_lua = '[lua]',
          }

          vim_item.menu = menus[entry.source.name] or ''

          local symbol_map = {
            Codeium = '󰑴',
          }

          vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = 'symbol_text' })

          if entry.source.name == 'codeium' then
            vim_item.kind = symbol_map['Codeium']
            vim_item.kind = vim_item.kind .. ' ML'
            vim_item.kind_hl_group = 'CustomCmpCodeium'
          end

          vim_item.kind = vim_item.kind .. ' ' .. vim_item.menu

          return vim_item
        end,
      },
      preselect = 'None',
      completion = { completeopt = 'menu,menuone,noselect,noinsert' },
      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),
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
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources(sources),
    }
  end,
}
