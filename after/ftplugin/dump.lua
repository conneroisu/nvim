vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = '*.dump',
  group = 'steeltrap_dump',
  command = 'mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*.dump',
  group = 'steeltrap_dump',
  command = 'silent! loadview'
})
