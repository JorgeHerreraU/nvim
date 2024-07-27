return {
  'altermo/ultimate-autopair.nvim',
  event = { 'InsertEnter', 'CmdlineEnter' },
  branch = 'v0.6',
  opts = {
    -- config_internal_pairs = {
    --   { '"', '"', suround = false, imap = false, cmap = false }, -- Disabling double quotes pairing
    --   { "'", "'", suround = false, imap = false, cmap = false }, -- Disabling single quotes pairing
    --   { '(', ')', suround = true, imap = true, cmap = true, disable_start = true },
    --   { '{', '}', suround = true, imap = true, cmap = true, disable_start = true },
    -- },
  },
}
