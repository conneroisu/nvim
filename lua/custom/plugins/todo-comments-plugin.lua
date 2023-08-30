--[=============[
   todo comments
   desc: Highlight and Search TODO, BUG, etc
   author: folke
   url: https://github.com/folke/todo-comments.nvim
--]=============]

return {
	"folke/todo-comments.nvim",
	event = "UIEnter",
	dependencies = "nvim-lua/plenary.nvim",
}
