vim.api.nvim_create_augroup('steeltrap_zig', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = '*.zig',
  group = 'steeltrap_zig',
  command = 'mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*.zig',
  group = 'steeltrap_zig',
  command = 'silent! loadview'
})
