---@module "better-escape-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
	"max397574/better-escape.nvim",
	config = function()
		require("better_escape").setup {
			mapping = { "jk" }, -- a table with mappings to use
		}
	end,
}
