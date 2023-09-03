--[============[
   nvim comment
   author: terrortylor
   github-name: nvim-comment 
   url: https://github.com/nvim-comment
--]============]
return {
	"terrortylor/nvim-comment",
	config = function()
		require("nvim_comment").setup({
			marker_padding = true,
			comment_empty = false,
			create_mappings = true,
			line_mapping = "gcc",
			operator_mapping = "gc",
			hooks = {},
		})
	end,
	lazy = true,

}
