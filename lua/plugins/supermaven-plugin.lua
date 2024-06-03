---@module "supermaven-plugin"
---@author "Conner Ohnesorge"
---@license WTFPL

return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_word = "<C-RIGHT>",
				accept_suggestion = "<C-j>"
			},
		})
	end,
}
--
--
-- return {
--         "github/copilot.vim",
--         config = function()
--         end,
-- }
