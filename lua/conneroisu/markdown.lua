---@module "markdown"
---@author Conner Ohnesorge
---@license WTFPL
local keymap = vim.keymap.set
local switch_filetype = false
local function switch_to_markdown()
	if switch_filetype then
		vim.cmd ":set filetype=markdown"
	end
end
local function switch_to_tex()
	if switch_filetype then
		vim.cmd ":set filetype=tex"
	end
end
keymap("n", "<leader>vmt", ":TableModeRealign<CR>", { silent = true, remap = true, desc = "Realign table" })
vim.g.table_mode_always_active = true
vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*.md", callback = switch_to_tex })
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*.md", callback = switch_to_markdown })
