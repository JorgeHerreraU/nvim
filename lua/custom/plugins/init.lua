-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Use `opts = {}` to force a plugin to be loaded.
  {
    'numToStr/FTerm.nvim',
    opts = {
      border = 'rounded',
    },
  },
  'ThePrimeagen/vim-be-good',
}
