vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = '*.vhd',
  group = 'steeltrap_vhdl',
  command = 'mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*.vhd',
  group = 'steeltrap_vhdl',
  command = 'silent! loadview'
})
