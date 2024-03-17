---@module "markdown"
---@author Conner Ohnesorge
---@license WTFPL

local keymap = vim.keymap.set
local current_nabla_virtual = false
local switch_filetype = false

--- This function sets up the keymaps for the LSP within markdown files.
local function update_otter()
	local otter = require 'otter'
	local languages = { 'python', 'lua', "typescript", "go", "json" }

	-- enable completion/diagnostics
	local completion = true
	local diagnostics = true
	-- treesitter query to look for embedded languages
	-- uses injections if nil or not set
	local tsquery = nil

	otter.activate(languages, completion, diagnostics, tsquery)
end

--- This function sets up the keymaps for the LSP within markdown files.
local function update_nabla_virtual()
	if current_nabla_virtual == true then
		require("nabla").enable_virt { align_center = true, autogen = true }
	else
		require("nabla").disable_virt()
	end
end

local function switch_virtual_preview()
	current_nabla_virtual = not current_nabla_virtual
	update_nabla_virtual()
end

local function switch_to_markdown()
	if not switch_filetype then
		return
	end
	vim.cmd ":set filetype=markdown"
	update_nabla_virtual()
end

local function switch_to_tex()
	if not switch_filetype then
		return
	end
	vim.cmd ":set filetype=tex"
end

keymap("n", "<leader>vms", function()
	switch_filetype = not switch_filetype
end, { silent = true, remap = true, desc = "Toggle Nabla file type" })
keymap("n", "<leader>vmv", switch_virtual_preview, { silent = true, remap = true, desc = "Toggle Nabla virtual preview" })
keymap("n", "<leader>vmp", require("nabla").popup, { silent = true, remap = true, desc = "Nabla popup" })
keymap("n", "<leader>vmt", ":TableModeRealign<CR>", { silent = true, remap = true, desc = "Realign table" })

vim.g.table_mode_always_active = true

vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*.md", callback = switch_to_tex })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*.md", callback = switch_to_markdown })
-- on opening of a markdown file, update_otter
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.md", callback = update_otter })

vim.cmd [[
  function! OpenMarkdownPreview (url)
    execute "silent ! firefox --new-window " . a:url
  endfunction
  let g:mkdp_browserfunc = 'OpenMarkdownPreview'
]]
