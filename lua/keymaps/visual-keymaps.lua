---@module "visual-keymaps"
---@author Conner Ohnesorge
---@license WTFPL

-- Bind Space in visual mode to do nothing (no operation) so that it can be used as a prefix key
vim.keymap.set('v', '<Space>', '<Nop>', {
  silent = true
})

-- Bind K in visual mode to move the selection up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
  desc = "Move visual selection up"
})
-- Bind J in visual mode to move the selection down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
  desc = "Move visual selection down"
})
-- Bind Leader+1 in visual line mode to increment all numbers in selection by 1
vim.keymap.set('x', '<C-S-1>', ':s/\\d\\+/\\=submatch(0)+1/g<CR>gv', {
  silent = true,
  desc = "Increment all numbers in selection by 1"
})
-- Bind 2 in visual mode to decrement all numbers in selection by 1
vim.keymap.set('x', '<C-S-2>', ':s/\\d\\+/\\=submatch(0)-1/g<CR>gv', {
  silent = true,
  desc = "Decrement all numbers in selection by 1"
})

vim.keymap.set("x", "<leader>om", 'c<Esc>oclass={<Space>twerge.Generate(\"<Esc>pa\")<Space>}<Esc>kdd',
  { remap = true, silent = true })

vim.keymap.set("v", "<leader>om", 'c<Esc>oclass={<Space>twerge.Generate(\"<Esc>pa\")<Space>}<Esc>kdd',
  { remap = true, silent = true })
