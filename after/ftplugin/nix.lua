-- Create an autocommand group for remembering folds in Nix files
vim.api.nvim_create_augroup('steeltrap_nix', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = '*.nix',
  group = 'steeltrap_nix',
  command = 'mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*.nix',
  group = 'steeltrap_nix',
  command = 'silent! loadview'
})
