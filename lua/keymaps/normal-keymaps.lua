---@module "normal-keymaps"
---@author Conner Ohnesorge
---@license WTFPL

--[===================[
   Normal Mode Keymaps
   normal-keymaps.lua
--]===================]

-- map space to no operation
vim.keymap.set("n", "<Space>", "<Nop>", {
    desc = "No Operation on Space"
})

-- Map J in normal mode to join lines by staying at the current postiion
vim.keymap.set("n", "J", "mzJ`z", {
    desc = "Join lines"
})

--- Bind leader + g + p to open the current working directory in the file explorer in normal mode
function OpenCurrent()
    local cwd = vim.fn.expand("%:p:h")
    local file = vim.fn.expand("%:t")
    -- ignore oil files and do cwd
    -- oil:///run/media/conner/source/001Repos/cpre381-project-1
    if string.match(cwd, "oil") then
        vim.cmd("!nautilus " .. " . " .. "&")
    else
        vim.cmd("!nautilus " .. file .. "&")
    end
end

-- bind leader + g + p to open the current working directory in the file explorer in normal mode
vim.keymap.set("n", "<C-e>", ":lua OpenCurrent()<CR>", {
    desc = "Open the current working directory in the file explorer for windows"
})

-- bind shift + j to Move Lines up in normal mode without moving the cursor
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", {
    desc = "Move down"
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
})

-- bind leader + e to open the init.lua file in normal mode
vim.api.nvim_set_keymap("n", "<leader>e", ":e $MYVIMRC<CR>", {
    noremap = true,
    silent = true,
    desc = "Open init.lua"
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

-- lazy
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>:Lazy<cr>", {
    desc = "Open Lazy"
})


-- Bind the previous file to alt+left like in a browser.
vim.api.nvim_set_keymap("n", "<A-Left>", ":edit #<cr>", {
    silent = true,
    desc = "Previous File"
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

-- Bind alt + shift + f to :Format in normal mode
vim.api.nvim_set_keymap("n", "<A-S-f>", ":Format<CR>", {
    desc = "Format"
})

-- Extract block supports only normal mode
vim.cmd("let g:VM_maps['Select Cursor Down'] = '<M-S-Down>'")
vim.cmd("let g:VM_maps['Select Cursor Up'] = '<M-S-Up>'")

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

-- map leader + l + l to restart the lsp in normal mode
vim.api.nvim_set_keymap("n", "<leader>ll", ":LspRestart<CR>", {
    noremap = true,
    silent = true,
    desc = "Restart LSP"
})

--[=======[
   VHDL
--]=======]
Compile_And_Link = function()
    vim.cmd(":!nvc -a " .. vim.fn.expand('%:p') .. " -e " .. vim.fn.expand('%:t:r') .. " -r " .. vim.fn.expand('%:t:r'))
end

Open_nvc = function()
    vim.cmd(
        ":!nvc -a " .. vim.fn.expand('%:p') .. " -e " .. vim.fn.expand('%:t:r') .. " -r " .. vim.fn.expand('%:t:r') ..
        " --format=fst -w && gtkwave " .. vim.fn.expand('%:t:r') .. ".fst")
end

-- map leader + v + n to run the current file with nvc
vim.api.nvim_set_keymap("n", "<leader>vn", ":lua Open_nvc()<CR>", {
    noremap = true,
    silent = true,
    desc = "Run the current file with nvc"
})

-- just compile using nvc when leader + v + b
vim.api.nvim_set_keymap("n", "<leader>vb", ":lua Compile_And_Link()<CR>", {
    noremap = true,
    silent = true,
    desc = "Run the current file with nvc"
})

-- go mod tidy on leager + g + m + t
vim.api.nvim_set_keymap("n", "<leader>gmt", ":!go mod tidy<CR>", {
    noremap = true,
    silent = true,
    desc = "Go Mod Tidy"
})

-- open the current file in obsidian with leader + o + b
vim.api.nvim_set_keymap("n", "<leader>ob", ":!obs open " .. vim.fn.expand('%:p') .. "<CR>", {
    noremap = true,
    silent = true,
    desc = "Open in Obsidian"
})

-- restart copilot with leader + c + r
vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>Copilot restart <CR>", {
    noremap = true,
    silent = true,
    desc = "Restart Copilot"
})

-- set leader + g + t to run go tests when in a go file
vim.api.nvim_set_keymap("n", "<leader>gt", ":GoTest<CR>", {
    noremap = true,
    silent = true,
    desc = "Run Go Tests"
})
