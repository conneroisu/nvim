--@module "nvim"
---@author Conner Ohnesorge
---@license WTFPL

--  (otherwise wrong leader will be used)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	}
end

vim.opt.rtp:prepend(lazypath)

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup {
	{
		-- must  be installed before lsp
		"folke/neodev.nvim",
		init = function()
			require("neodev").setup()
		end,
	},
	"tpope/vim-rhubarb",
	"tpope/vim-sleuth",
	{
		import = "plugins",
	},
}

require "config.options"
require "misc.lsp-config"

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

--- This function sets up the keymaps for the LSP within markdown files.
---@param it table
---@param bufnr number
local on_attach = function(it, bufnr)
	if it == nil then
		return
	end
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, {
			buffer = bufnr,
			desc = desc,
		})
	end
	nmap(
		"<leader>rn",
		vim.lsp.buf.rename,
		"[R]e[n]ame"
	)
	nmap(
		"<leader>cf",
		":Lspsaga code_action<CR>",
		"[C]ode [A]ction"
	)
	nmap(
		"<leader>pd",
		":Lspsaga peek_definition<CR>",
		"[P]eek [D]efinition"
	)
	nmap(
		"gd",
		vim.lsp.buf.definition,
		"[G]oto [D]efinition"
	)
	nmap(
		"gr",
		require('telescope.builtin').lsp_references,
		"[G]oto [R]eferences"
	)
	nmap(
		"gI",
		vim.lsp.buf.implementation,
		"[G]oto [I]mplementation"
	)
	nmap(
		"<leader>D",
		vim.lsp.buf.type_definition,
		"Type [D]efinition"
	)
	nmap(
		"<leader>ds",
		require('telescope.builtin').lsp_document_symbols,
		"[D]ocument [S]ymbols"
	)
	nmap(
		"<leader>ws",
		require('telescope.builtin').lsp_dynamic_workspace_symbols,
		"[W]orkspace [S]ymbols"
	)
	nmap(
		"<C-k>", vim.lsp.buf.signature_help,
		"Signature Documentation"
	)
	nmap(
		"gD",
		vim.lsp.buf.declaration,
		"[G]oto [D]eclaration"
	)
	nmap(
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		"[W]orkspace [A]dd Folder"
	)
	nmap(
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		"[W]orkspace [R]emove Folder"
	)
	nmap(
		"<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end,
		"[W]orkspace [L]ist Folders"
	)
	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {
		desc = "Format current buffer with LSP",
	})

	local client = vim.lsp.get_client_by_id(it.id)
	require('sqls').on_attach(client, bufnr)
end

--  define the property "filetypes" to the map in question, to override the default filetypes of a server.
local servers = {
	gopls = {},
	htmx = {},
	svelte = {},
	tsserver = {},
	ltex = {},
	texlab = {},
	dockerls = {},
	tailwindcss = {
		filetypes = {
			"css",
			"scss",
			"javascript",
			"typescript",
			"astro",
			"svelte",
			"vue",
			"templ"
		}
	},
	html = {
		filetypes = { "html", "twig", "hbs" },
	},
	lua_ls = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
	hdl_checker = {
		filetypes = { "vhdl", "verilog", "systemverilog" },
		cmd = { "hdl_checker", "--lsp" },
	},
}

local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}
local capabilities = vim.lsp.protocol.make_client_capabilities()

mason_lspconfig.setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end,
}

vim.cmd "syntax on"
vim.cmd "set wrap!"

require "keymaps.visual-keymaps"
require "keymaps.insert-keymaps"
require "keymaps.normal-keymaps"

vim.o.statusline = vim.o.statusline .. "%F"
local builtin = require "telescope.builtin"
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local lsp_config_util = require "lspconfig/util"
if not lspconfig.hdl_checker then
	lspconfig.hdl_checker = {
		default_config = {
			cmd = { "hdl_checker", "--lsp" },
			filetypes = {
				"vhdl",
				"verilog",
				"systemverilog",
				"vhd"
			},
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
			end,
			settings = {},
		},
	}
end
if not lspconfig.ghdl_ls then
	lspconfig.ghdl_ls = {
		default_config = {
			cmd = { "ghdl_ls" },
			filetypes = { "vhdl", "vhd" },
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
			end,
			settings = {},
		},
	}
end
vim.keymap.set("n", "<leader>fi", builtin.find_files, { desc = "Find Files" })
vim.cmd "set rtp^='/home/conner/.opam/default/share/ocp-indent/vim'"

require "misc.markdown"

-- Register the language
vim.filetype.add { extension = { templ = "templ", } }

vim.treesitter.language.register("templ", "templ")
if not configs.templ then
	configs.templ = {
		default_config = {
			cmd = { "templ", "lsp" },
			filetypes = { "templ" },
			root_dir = lsp_config_util.root_pattern("go.mod", ".git"),
			settings = {},
		},
	}
end

lspconfig.vhdl_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	auto_start = true,
	filetypes = { "vhdl", "vhd", "verilog", "systemverilog" },
	default_config = {
		filetypes = { "vhdl", "vhd", "verilog", "systemverilog" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = function(fname)
			return lsp_config_util.root_pattern('vhdl_ls.toml')(fname)
		end,
	}
}

lspconfig.sqls.setup {
	on_attach = function(client, bufnr)
		require('sqls').on_attach(client, bufnr)
	end
}

vim.lsp.set_log_level("debug")
local client = vim.lsp.start_client({
	name = "pytrance",
	cmd = { "/run/media/conner/source/001Repos/pytrance/main" },
	on_attach = on_attach,
})
if not client then
	print("Failed to start pytrance")
	return
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.lsp.buf_attach_client(0, client)
	end,
})

local lspconfutil = require 'lspconfig/util'
local root_pattern = lspconfutil.root_pattern("veridian.yml", ".git")
require('lspconfig').veridian.setup {
	cmd = { 'veridian' },
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = function(fname)
		local filename = lspconfutil.path.is_absolute(fname) and fname
		    or lspconfutil.path.join(vim.loop.cwd(), fname)
		return root_pattern(filename) or lspconfutil.path.dirname(filename)
	end,
}

-- basedpyright
lspconfig.basedpyright.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

