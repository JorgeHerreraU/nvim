return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git', -- also try out "git_branch"
  },
  event = { 'VimEnter' },
  cmd = 'Grapple',
  keys = {
    { '<leader>oa', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>ol', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<leader>oo', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
    { '<leader>op', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
    { '<leader>od', '<cmd>Grapple reset<cr>', desc = 'Grapple reset' },
    { '<A-0>', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select tag 1' },
    { '<A-9>', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select tag 2' },
    { '<A-8>', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select tag 3' },
    { '<A-7>', '<cmd>Grapple select index=4<cr>', desc = 'Grapple select tag 4' },
    { '<A-6>', '<cmd>Grapple select index=5<cr>', desc = 'Grapple select tag 5' },
  },
  config = function(_, opts)
    require('grapple').setup(opts)

    local function should_tag_buffer(bufnr)
      local excluded_filetypes = { 'qf', 'help', 'netrw' }
      return not vim.tbl_contains(excluded_filetypes, vim.bo[bufnr].filetype)
    end

    local function tag_current_buffer()
      local bufnr = vim.api.nvim_get_current_buf()
      if should_tag_buffer(bufnr) then
        require('grapple').tag()
      end
    end

    -- Create a custom command to tag the current buffer
    vim.api.nvim_create_user_command('GrappleTagBuffer', tag_current_buffer, {})

    -- Automatically tag buffer on opening
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
      callback = function(ev)
        if should_tag_buffer(ev.buf) then
          vim.schedule(function()
            vim.cmd 'GrappleTagBuffer'
          end)
        end
      end,
    })

    -- Tag the first opened file
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.schedule(function()
          vim.cmd 'GrappleTagBuffer'
        end)
      end,
      once = true,
    })
  end,
}
