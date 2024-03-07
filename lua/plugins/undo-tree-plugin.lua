return {
	"mbbill/undotree",
	config = function()
		-- bind leader + u + u to toggle the undo tree view in normal mode
		vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, {
			desc = "Open Undo Tree"
		})
	end
}
