return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			"lazy.nvim",
			"luvit-meta/library",
			"LazyVim",
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
