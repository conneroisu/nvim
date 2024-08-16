---@module "options"
---@author Conner Ohnesorge
---@license WTFPL

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- set hybrid line numbers
vim.o.number = true
vim.o.relativenumber = true
-- set the color column to 80
-- vim.o.colorcolumn = "80"
vim.o.termguicolors = true

-- -- disable netrw in favor of Oil
-- vim.o.loaded_netrw = 0
-- vim.o.loaded_netrwPlugin = 0

-- set termguicolors to true
vim.o.termguicolors = true

-- set the clipboard to use the system clipboard
vim.o.clipboard = "unnamedplus"

-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- set the scroll off of the buffer when lsp is attached to said buffer to 8
vim.o.scrolloff = 8

-- set hybrid line numbers 
vim.o.relativenumber = true
vim.o.number = true

vim.opt.undofile = true

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = "left"

-- Set a language to use its alternate delimiters by default
vim.g.NERDAltDelims_java = 1

-- Add your own formats or override the defaults
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

-- Qutting for specific file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
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

vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#0ad691", bold = false })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#35ea83", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#0ad691", bold = false })

-- Remap Command 'Wq' to 'wq'
vim.cmd(":command Wq wq")
-- Remap Command 'VS' to 'vs'
vim.cmd(":command VS vs")
-- Remap Command 'Vs' to 'vs'
vim.cmd(":command Vs vs")
-- Remap Command 'W' to 'w'
vim.cmd(":command W w")
-- Remap Command 'Q' to 'q'
vim.cmd(":command Q q")

-- set leader + p to "\"_dp allows for pasting without losing yanked text
vim.api.nvim_set_keymap("x", "<leader>p", "\"_dp", {
	noremap = true,
	silent = true
})

-- Python Host Program
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.python_host_prog = "/usr/bin/python"
