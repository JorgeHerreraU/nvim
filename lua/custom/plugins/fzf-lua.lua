return {
  'ibhagwan/fzf-lua',
  lazy = false,
  config = function()
    local fzf = require 'fzf-lua'
    vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find: Files' })
    vim.keymap.set('n', '<leader>fd', fzf.git_files, { desc = 'Find: Git Files' })
    vim.keymap.set('n', '<leader>/', fzf.live_grep, { desc = 'Find: LiveGrep' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = 'Find: Buffers' })
    vim.keymap.set('n', '<leader>fw', fzf.grep_cword, { desc = 'Find: Grep current Word' })
    vim.keymap.set('n', '<leader>fW', fzf.grep_cWORD, { desc = 'Find: Grep current Word' })
    vim.keymap.set('n', '<leader>f.', fzf.oldfiles, { desc = 'Find: Old files' })
    vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = 'Find: LSP References' })
    vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = 'Find: LSP Definitions' })
    require('fzf-lua').setup {
      fzf_opts = {
        ['--no-scrollbar'] = true,
      },
      lsp = {
        jump_to_single_result = true, -- automatically jump if there is only one result
      },
      winopts = {
        async_renders = true,
        animate = false,
        hl_cursorline = false,
        border = 'none',
      },
    }
  end,
}
