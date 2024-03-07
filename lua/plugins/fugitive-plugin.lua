---@module "fugitive-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
	"tpope/vim-fugitive",
	config = function()
		-- bind leader + h + u to open Git from fugitive in normal mode
		vim.api.nvim_set_keymap("n", "<leader>hu", "<cmd>Git<cr>", {
			desc = "Git"
		})
	end
}
