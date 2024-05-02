vim.api.nvim_create_user_command('FormatDisable', function(args)
  vim.g.disable_autoformat = true
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
