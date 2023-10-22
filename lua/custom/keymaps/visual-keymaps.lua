
vim.keymap.set( 'v' , '<Space>', '<Nop>', {
    silent = true
})

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move visual selection up"
})
-- Bind J and K in visual mode to move the seslection up and down respectively
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move visual selection down"
})
