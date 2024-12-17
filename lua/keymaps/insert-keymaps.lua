---@module "insert-keymaps"
---@author Conner Ohnesorge
---@license WTFPL

-- -- bind Ctrl + Space to view options from cmp in insert mode
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {
--     noremap = true,
--     silent = true,
--     expr = true
-- })

-- bind move line down to Alt + j in insert mode
vim.api.nvim_set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", {
    desc = "Move down"
})

-- bind move line up to Alt + k in insert mode
vim.api.nvim_set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", {
    desc = "Move up"
})
