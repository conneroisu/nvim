
-- Shifting  ===========================================================
vim.keymap.set("n", "<Space>", "<Nop>", {
    desc = "No Operation on Space"
})
-- '})
-- Map J in normal mode to join lines by staying at the current postiion
vim.keymap.set("n", "J", "mzJ`z", {
    desc = "Join lines"
})

  vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
vim.keymap.set("n", "<C-e>", ":!explorer .", {
    desc = "Open the current working directory in the file explorer for windows"
})
-- Move Lines up and down with alt j and alt k in normal mode
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", {
    desc = "Move down"
})
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", {
    desc = "Move up"
})

vim.keymap.set("n", "K", "<CMD>lua _G.show_docs()<CR>", {
    silent = true,
    desc = "Show Documentation for item under cursor"
})
-- bind Control + o to open recent files in normal mode
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope oldfiles<CR>", {
    noremap = true,
    silent = true,
    desc = "Open Recent Files"
})

-- macos
vim.cmd([[command! -nargs=0 IO execute "silent !open 'obsidian://open?vault=SecondBrain&file=" . expand('%:t:r') . "'"]])
vim.api.nvim_set_keymap("n", "<leader>io", ":IO<CR>", {
    noremap = true,
    silent = true,
    desc = "Open in Obsidian (MacOS)"
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


-- set leader + c + f to quickfix with lsp in normal mode 
vim.api.nvim_set_keymap("n", "<leader>cf", ":lua vim.lsp.buf.code_action()<CR>", {
    desc = "Quickfix with LSP"
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

-- Bind harpoon go to first mark to Alt + 1 
vim.api.nvim_set_keymap("n", "<M-1>", ":lua require('harpoon.ui').nav_file(1)<CR>", {
    noremap = true,
    silent = true,
    desc = "Navigate to first harpoon mark"
})

-- Bind harpoon go to second mark to Ctrl + 2
vim.api.nvim_set_keymap("n", "<M-2>", ":lua require('harpoon.ui').nav_file(2)<CR>", {
    noremap = true,
    silent = true,
    desc = "Navigate to second harpoon mark"
})

-- Bind harpoon go to third mark to Ctrl + 3
vim.api.nvim_set_keymap("n", "<M-3>", ":lua require('harpoon.ui').nav_file(3)<CR>", {
    noremap = true,
    silent = true,
    desc = "Navigate to third harpoon mark"
})

-- Bind harpoon go to fourth mark to Ctrl + 4
vim.api.nvim_set_keymap("n", "<C-4>", ":lua require('harpoon.ui').nav_file(4)<CR>", {
    noremap = true,
    silent = true,
    desc = "Navigate to fourth harpoon mark"
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

vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, {
    desc = "Open Undo Tree"
})

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


-- Function to get the cwd of the current buffer 
function _G.get_cwd()
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local cwd = vim.fn.fnamemodify(bufname, ":h")
    return cwd
end

-- Bind leader + b + p to copy the current buffer path to the clipboard
vim.api.nvim_set_keymap("n", "<leader>bp", ":let @*=expand('%:p')<CR>", {
    desc = "Copy buffer path to clipboard"
})


-- bind alt + shift + f to :Format in normal mode
vim.api.nvim_set_keymap("n", "<A-S-f>", ":Format<CR>", {
    desc = "Format"
})

vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set( "n", "<leader>rI", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
vim.keymap.set("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end)
-- Extract function supports only visual mode
vim.keymap.set("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end)
-- Extract variable supports only visual mode
vim.keymap.set("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end)
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end)
-- Inline var supports both normal and visual mode

vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end)
-- Extract block supports only normal mode
vim.cmd("let g:VM_maps['Select Cursor Down'] = '<M-S-Down>'")
vim.cmd("let g:VM_maps['Select Cursor Up'] = '<M-S-Up>'")


-- Open file in Obsidian vault
-- macos
vim.cmd([[command! -nargs=0 IO execute "silent !open 'obsidian://open?vault=SecondBrain&file=" . expand('%:t:r') . "'"]])
vim.api.nvim_set_keymap("n", "<leader>io", ":IO<CR>", {
    noremap = true,
    silent = true,
    desc = "Open in Obsidian (MacOS)"
})

vim.api.nvim_set_keymap("n", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("n", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Go to previous diagnostic message'
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Go to next diagnostic message'
})

-- buffers
vim.api.nvim_set_keymap("n", "<C-Left>", "<cmd>bprevious<cr>", {
    desc = "Prev buffer"
})

vim.api.nvim_set_keymap("n", "<C-Right>", "<cmd>bnext<cr>", {
    desc = "Next buffer"
})

vim.api.nvim_set_keymap("n", "[b", "<cmd>bprevious<cr>", {
    desc = "Prev buffer"
})

vim.api.nvim_set_keymap("n", "]b", "<cmd>bnext<cr>", {
    desc = "Next buffer"
})

-- bind leader + x + L to open location list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", {
    desc = "Location List (Trouble)"
})

--[=======[
   Neotest
--]=======]
vim.api.nvim_set_keymap("n", "<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>", {
    noremap = true,
    silent = true
})




