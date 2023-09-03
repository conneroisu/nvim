-- Map J in normal mode to join lines by staying at the current postiion
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

vim.keymap.set("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true , desc = "Show Documentation for item under cursor"})
-- bind Control + o to open recent files in normal mode
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope oldfiles<CR>", {
    noremap = true,
    silent = true,
    desc = "Open Recent Files"
})

--macos
vim.cmd(
	[[command! -nargs=0 IO execute "silent !open 'obsidian://open?vault=SecondBrain&file=" . expand('%:t:r') . "'"]]
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>io",
	":IO<CR>",
	{ noremap = true, silent = true, desc = "Open in Obsidian (MacOS)" }
)
-- Move Lines up and down with alt j and alt k in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", {
    desc = "Move down"
})
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", {
    desc = "Move up"
})

-- bind the leader + u + n to dismiss all notifications in normal mode
vim.api.nvim_set_keymap("n", "<leader>un", "<cmd>lua require('notify').dismiss({silent = true, pending = true})<cr>", {
    desc = "Dismiss all Notifications"
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
})
-- set leader key + c + o to toggle comments in normal and visual mode
vim.api.nvim_set_keymap("n", "<leader>co", "<cmd>CommentToggle<cr>", {
    desc = "Comment Toggle"
})
-- map leader + x + x to toggle the document diagnostics from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", {
    desc = "Document Diagnostics (Trouble)"
})
-- map leader + x + X to toggle the workspace diagnostics from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", {
    desc = "Workspace Diagnostics (Trouble)"
})
-- bind leader + x + L to toggle the loclist from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", {
    desc = "Location List (Trouble)"
})
-- bind leader + x + Q to toggle the quickfix list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", {
    desc = "Quickfix List (Trouble)"
})
-- bind leader + a + g to generate a github commit message from the git diff in normal mode
vim.api.nvim_set_keymap("n", "<leader>ag", ":NeoAIShortcut gitcommit<CR>", {
    desc = "Generate a git diff commit message."
})
-- bind leader + u + u to toggle the undo tree view in normal mode
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, {
    desc = "Open Undo Tree"
})
-- bind leader + g + p to open telescope projects in normal mode
vim.api.nvim_set_keymap("n", "<leader>gp", ":Telescope projects<CR>", {
    desc = "Open Telesope projects "
})
-- bind leader + m to open oil file explorer in normal mode
vim.api.nvim_set_keymap("n", "<leader>m", ":Oil<CR>", {
    noremap = true,
    silent = true, 
    desc = "Open Oil File Explorer"
})
-- bind leader + h + u to open Git from fugitive in normal mode
vim.api.nvim_set_keymap("n", "<leader>hu", "<cmd>Git<cr>", {
    desc = "Git"
})
-- bind leader + e to open the init.lua file in normal mode
vim.api.nvim_set_keymap("n", "<leader>e", ":e $MYVIMRC<CR>", {
    noremap = true,
    silent = true,
    desc = "Open init.lua"
})

-- bind leader + f + f to open telescope in normal mode for files
vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", {
    desc = '[F]ind [F]iles'
})


-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, {
    desc = '[?] Find recently opened files'
})

vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, {
    desc = '[ ] Find existing buffers'
})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false
    })
end, {
    desc = '[/] Fuzzily search in current buffer'
})

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
    desc = 'Search [G]it [F]iles'
})
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {
    desc = '[S]earch [F]iles'
})
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {
    desc = '[S]earch [H]elp'
})
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {
    desc = '[S]earch current [W]ord'
})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {
    desc = '[S]earch by [G]rep'
})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {
    desc = '[S]earch [D]iagnostics'
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
    silent = true,
    desc = "Open Oil File Explorer"
})

-- lazy
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>:Lazy<cr>", {
    desc = "Open Lazy"
})

vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, {desc="Open Undo Tree"})

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
    silent = true, 
    desc = "Previous File"
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
