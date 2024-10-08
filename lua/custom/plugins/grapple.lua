return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git', -- also try out "git_branch"
  },
  event = { 'BufReadPost', 'BufNewFile' },
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
  },
}
