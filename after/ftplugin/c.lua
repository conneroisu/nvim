vim.api.nvim_create_augroup('steeltrap_c', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = '*.c',
  group = 'steeltrap_c',
  command = 'mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*.c',
  group = 'steeltrap_c',
  command = 'silent! loadview'
})

vim.opt_local.shiftwidth = 2
vim.opt_local.formatoptions:remove "o"
