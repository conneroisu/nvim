--[==========[
   catppuccin
   desc: theme for neovim
   author: catppuccin (@catppuccin)
   url: https://github.com/catppuccin/nvim
--]==========]
return {
	"catppuccin/nvim",
	lazy = true,
	name = "catppuccin",
	opts = {
		integrations = {
			alpha = true,
			cmp = true,
			gitsigns = true,
			illuminate = true,
			indent_blankline = { enabled = true },
			lsp_trouble = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			navic = { enabled = true },
			neotest = true,
			noice = true,
			notify = true,
			nvimtree = true,
			semantic_tokens = true,
			telescope = true,
			treesitter = true,
			which_key = true,
		},
	},
	config = function()
		require("catppuccin").setup({

			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				coc_nvim = true,
				markdown = true,
				treesitter = true,
				treesitter_context = true,
				octo = true,
				notify = true,
				lsp_trouble = true,
				which_key = true,
				alpha = true,
				mini = false,
			},
		})
	end,
}
