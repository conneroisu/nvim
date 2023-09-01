-- Map J in normal mode to join lines by staying at the current postiion
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- bind space + space to open telescope in normal mode for files 
vim.api.nvim_set_keymap("n", "<space><space>", ":Telescope find_files<CR>", {
    noremap = true,
    silent = true,
    desc = "Open Files for Project using Telescope"
})

-- bind harpoon view all project marks to space + h
vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {
    noremap = true,
    silent = true,
    desc = "View all harpoon marks"
})

-- bind harpoon navigate next to alt + h
vim.api.nvim_set_keymap("n", "<M-h>", ":lua require('harpoon.ui').nav_next()<CR>", {
    noremap = true,
    silent = true,
    desc = "Navigate to next harpoon mark"
})

-- bind harpoon navigate previous to alt + l
vim.api.nvim_set_keymap("n", "<M-l>", ":lua require('harpoon.ui').nav_prev()<CR>", {
    noremap = true,
    silent = true,
    desc = "Navigate to previous harpoon mark"
})

-- bind harpoon mark / add file to space + m
vim.api.nvim_set_keymap("n", "<space>m", ":lua require('harpoon.mark').add_file()<CR>", {
    noremap = true,
    silent = true,
    desc = "Add file to harpoon list of files"
})

-- bind shift + h to move to the start of the line in normal mode
vim.api.nvim_set_keymap("n", "<S-h>", "^", {
    noremap = true,
    silent = true,
    desc = "Move cursor to the start of the line"
})
-- bind shift + l to move to the end of the line in normal mode
vim.api.nvim_set_keymap("n", "<S-l>", "$", {
    noremap = true,
    silent = true,
    desc = "Move cursor to the end of the line"
})

-- bind leader + m to open oil file explorer in normal mode
vim.api.nvim_set_keymap("n", "<leader>m", ":Oil<CR>", {
    noremap = true,
    silent = true
})


-- map telescope live_grep to leader + l + g
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", {
    desc = "Open Telescope Live Grep"
})


-- Bind redo to Ctrl + Y
vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>redo<cr>", {
    desc = "Redo"
})
-- -- tabs
-- vim.api.nvim_set_keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", {
--     desc = "Last Tab"
-- })
-- vim.api.nvim_set_keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", {
--     desc = "First Tab"
-- })
-- vim.api.nvim_set_keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", {
--     desc = "New Tab"
-- })
-- vim.api.nvim_set_keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", {
--     desc = "Next Tab"
-- })
-- vim.api.nvim_set_keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", {
--     desc = "Close Tab"
-- })
-- vim.api.nvim_set_keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", {
--     desc = "Previous Tab"
-- })
