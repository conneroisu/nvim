-- Map J in normal mode to join lines by staying at the current postiion
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- bind Control + o to open recent files in normal mode
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope oldfiles<CR>", {
    noremap = true,
    silent = true
})

vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", {
    desc = '[F]ind [F]iles'
})
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

-- lazy
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>:Lazy<cr>", {
    desc = "Lazy"
})
-- bind leader + u + u to open undotree in normal mode
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)

-- bind <leader> + x + w to open workspace diagnostics
vim.api.nvim_set_keymap("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", {
    desc = "Workspace Diagnostics (Trouble)"
})
-- bind leader + g + h to open the Octo github issue list in normal mode
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>:Octo issues<CR>", {
    desc = "Open the Octo issue list"
})

-- map telescope live_grep to leader + l + g
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", {
    desc = "Open Telescope Live Grep"
})

-- bind <leader> + x + x to open document diagnostics in normal mode
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", {
    desc = "Document Diagnostics (Trouble)"
})
-- bind leader + x + Q to open quickfix list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", {
    desc = "Quickfix List (Trouble)"
})

-- Bind the previous file to alt+left like in a browser.
vim.api.nvim_set_keymap("n", "<A-Left>", ":edit #<cr>", {
    silent = true
})

-- open the diagnostics list with leader + q
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostics list'
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
