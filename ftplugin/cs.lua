-- Check if the necessary functions are available
if pcall(require, 'omnisharp_extended') then
  -- Define the key mapping for C# files only
  vim.api.nvim_buf_set_keymap(
    0,
    'n',
    'gd',
    "<cmd>lua require('omnisharp_extended').lsp_definitions()<CR>",
    { noremap = true, silent = true, desc = '[G]oto [D]efinition' }
  )
end
--
-- vim.api.nvim_buf_set_keymap(
--   0,
--   'n',
--   'gd',
--   "<cmd>lua require('csharpls_extended').lsp_definitions()<CR>",
--   { noremap = true, silent = true, desc = '[G]oto [D]efinition' }
-- )
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.expandtab = true
