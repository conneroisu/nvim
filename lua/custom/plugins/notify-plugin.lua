--[======[
   notify
   desc: A fancy, configurable, notification manager for NeoVim 
   author: rcarriga
   url: https://github.com/rcarriga/nvim-notify
--]======]

return {
	"rcarriga/nvim-notify",
	Event = "VeryLazy",
	opts = {
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	},
}
