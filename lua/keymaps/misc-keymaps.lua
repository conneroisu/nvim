---@module "misc-keymaps"
---@author Conner Ohnesorge
---@license WTFPL


vim.api.nvim_set_keymap("x", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("x", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
vim.api.nvim_set_keymap("o", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("o", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n>", {
    desc = "Enter Normal Mode"
})
vim.api.nvim_set_keymap("t", "<c-_>", "<cmd>close<cr>", {
    desc = "which_key_ignore"
})
