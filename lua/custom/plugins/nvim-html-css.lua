return {
  -- install instructions
  -- sudo apt install fd-find
  -- update .zshrc: alias fd=fdfind
  -- create symlink: sudo ln -s $(which fdfind) /usr/local/bin/fd
  'Jezda1337/nvim-html-css',
  lazy = true,
  ft = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('html-css'):setup()
  end,
}
