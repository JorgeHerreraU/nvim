-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

local general = vim.api.nvim_create_augroup('General', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank-group', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('Bufenter', {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  group = general,
  desc = 'Disable new line comment',
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  once = true,
  callback = function()
    if vim.fn.has 'win32' == 1 or vim.fn.has 'wsl' == 1 then
      vim.g.clipboard = {
        copy = {
          ['+'] = 'win32yank.exe -i --crlf',
          ['*'] = 'win32yank.exe -i --crlf',
        },
        paste = {
          ['+'] = 'win32yank.exe -o --lf',
          ['*'] = 'win32yank.exe -o --lf',
        },
      }
    elseif vim.fn.has 'unix' == 1 then
      if vim.fn.executable 'xclip' == 1 then
        vim.g.clipboard = {
          copy = {
            ['+'] = 'xclip -selection clipboard',
            ['*'] = 'xclip -selection clipboard',
          },
          paste = {
            ['+'] = 'xclip -selection clipboard -o',
            ['*'] = 'xclip -selection clipboard -o',
          },
        }
      elseif vim.fn.executable 'xsel' == 1 then
        vim.g.clipboard = {
          copy = {
            ['+'] = 'xsel --clipboard --input',
            ['*'] = 'xsel --clipboard --input',
          },
          paste = {
            ['+'] = 'xsel --clipboard --output',
            ['*'] = 'xsel --clipboard --output',
          },
        }
      end
    end

    vim.opt.clipboard = 'unnamedplus'
  end,
  desc = 'Lazy load clipboard',
})
