return {
	"preservim/nerdcommenter",

	config = function()
		-- set leader key + c + o to toggle comments in normal and visual mode
		vim.api.nvim_set_keymap("n", "<leader>co", "<cmd>CommentToggle<cr>", {
			desc = "Comment Toggle"
		})
	end
}
