---@module "visual-keymaps"
---@author Conner Ohnesorge
---@license WTFPL

-- Bind Space in visual mode to do nothing (no operation) so that it can be used as a prefix key
vim.keymap.set( 'v' , '<Space>', '<Nop>', {
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
