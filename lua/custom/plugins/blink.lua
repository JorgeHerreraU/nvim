return {
  'saghen/blink.cmp',
  enabled = false,
  version = 'v0.*',
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  opts = {
    keymap = {
      preset = 'super-tab',
      ['<CR>'] = { 'accept', 'fallback' },
    },
    snippets = {
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction)
        require('luasnip').jump(direction)
      end,
    },
    sources = {
      min_keyword_length = 2,
      default = { 'lsp', 'path', 'luasnip' },
    },
    completion = {
      list = {
        selection = 'preselect',
      },
    },
  },
}
