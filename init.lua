--@module "nvim"
---@author Conner Ohnesorge
---@license WTFPL

--  (otherwise wrong leader will be used)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	}
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"lazy.nvim",
				"luvit-meta/library",
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "tpope/vim-sleuth" },
	{
		import = "plugins",
	},
}

require "conneroisu.options"

local highlight_group = vim.api.nvim_create_augroup(
	"YankHighlight",
	{ clear = true }
)

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
vim.cmd "syntax on"
vim.cmd "set wrap!"

require "keymaps.visual-keymaps"
require "keymaps.insert-keymaps"
require "keymaps.normal-keymaps"

vim.o.statusline = vim.o.statusline .. "%F"
-- Register the .templ filetype
vim.filetype.add { extension = { templ = "templ", } }
vim.treesitter.language.register("templ", "templ")

-- -- Format SQL files with sleek
-- vim.api.nvim_create_autocmd("BufWritePre", {
--         pattern = "*.sql",
--         group = vim.api.nvim_create_augroup("FormatSQL", { clear = true }),
--         callback = function()
--                 local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--                 local bufr_content = table.concat(content, "\n")
--                 local cmd = "echo \"" .. bufr_content .. "\" | sleek -i 4"
--                 local handle, err = io.popen(cmd, "r")
--                 if handle then
--                         local result = handle:read("*a")
--                         handle:close()
--                         local active_file = io.open(vim.fn.expand "%", "w")
--                         if not active_file then
--                                 print("Failed to open file for writing")
--                                 return
--                         end
--                         active_file:write(result)
--                         active_file:close()
--                         vim.cmd "e!"
--                 else
--                         print("Error running command:", err)
--                 end
--         end,
-- })

-- vim.cmd "set list"
-- vim.cmd("set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<")

local function clear_lsp_log()
	local log_path = vim.fn.expand("~/.local/state/nvim/lsp.log")
	local file = io.open(log_path, "w")
	if file then
		file:close()
		print("lsp.log cleared.")
	else
		print("Error: Could not open lsp.log.")
	end
end

vim.api.nvim_create_user_command('LspLogClear', clear_lsp_log, {})

vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- vim.api.nvim_create_user_command("SeltablStateLogs", function()
--         local log_path = vim.fn.expand("~/.config/seltabls/state.log")
--         vim.cmd(":e " .. log_path)
-- end, {})

-- vim.lsp.set_log_level("debug")
vim.filetype.add {
	extension = { rasi = 'rasi' },
	pattern = {
		['.*/waybar/config'] = 'jsonc',
		['.*/mako/config'] = 'dosini',
		['.*/kitty/*.conf'] = 'bash',
		['.*/hypr/.*%.conf'] = 'hyprlang',
	},
}
