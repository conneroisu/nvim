--[================[
   markdown preview
   desc: Allows for the prerviewing of rerndered markdown files in the browser. 
   author: iamcco (https://github.com/iamcco)
   url: https://github.com/iamcco/markdown-preview.nvim
--]================]
return {
	"iamcco/markdown-preview.nvim",
	Event = "UIEnter",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
