--[=============[
   dev container
   desc: Dev Containers support for Neovim 
   author: esensar
   url: https://github.com/esensar/nvim-dev-container
--]=============]
return {
	"https://codeberg.org/esensar/nvim-dev-container",
	Event = "VeryLazy",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
   lazy = true,
}
