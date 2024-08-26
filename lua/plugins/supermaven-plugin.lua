---@module "supermaven-plugin"
---@author "Conner Ohnesorge"
---@license WTFPL

return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_word = "<C-RIGHT>",
				accept_suggestion = "<C-j>"
			},
			disable_inline_completion = false,
		})
	end,
}
