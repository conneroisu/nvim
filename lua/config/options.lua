--[=======[
   Options
   desc: main configuration file for options of vim for personal configuration of neovim written in lua.
   path: C:/Users/Conne/AppData/Local/nvim/lua/options.lua
--]=======]

-- set termguicolors to true
vim.o.termguicolors = true

-- set the clipboard to use the system clipboard
vim.o.clipboard = "unnamedplus"

-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1


vim.opt.undofile = true

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = "left"

-- Set a language to use its alternate delimiters by default
vim.g.NERDAltDelims_java = 1

-- Add your own custom formats or override the defaults
vim.g.NERDCustomDelimiters = { c = { left = "/**", right = "*/" } }

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1

-- Enable NERDCommenterToggle to check all selected lines is commented or not
vim.g.NERDToggleCheckAllLines = 1

-- netrw config
vim.g.netrw_browser_split = 0

-- Set the netrw banner vertical split to zero
vim.g.netrw_banner = 0

-- set the windowsize of netrw to 25
vim.g.netrw_winsize = 25

-- Pearl provider set to null
vim.g.loaded_perl_provider = 0

-- turn on the mouse option a for neovim
vim.opt.mouse = "a"

-- turn off swap files
vim.opt.swapfile = false

-- quiting
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"fugitive",
		"ObsidianBacklinks",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"fugitive",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#35ea83", bold = true })

vim.api.nvim_set_hl(0, "LineNr", { fg = "#35ea83", bold = true })

vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#35ea83", bold = true })
