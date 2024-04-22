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

local on_attach = function(_, bufnr)
	local builtin = require "telescope.builtin"

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {
		desc = "Format current buffer with LSP",
	})
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
		vim.lsp.buf.code_action,
		"[C]ode [A]ction"
	)
	nmap(
		"gd",
		vim.lsp.buf.definition,
		"[G]oto [D]efinition"
	)
	nmap(
		"gr",
		builtin.lsp_references,
		"[G]oto [R]eferences"
	)
	nmap(
		"<leader>sr",
		builtin.resume,
		"[R]esume [S]earch"
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
		builtin.lsp_document_symbols,
		"[D]ocument [S]ymbols"
	)
	nmap(
		"<leader>ws",
		builtin.lsp_workspace_symbols,
		"[W]orkspace [S]ymbols"
	)
	nmap(
		"<C-k>",
		vim.lsp.buf.signature_help,
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
	nmap(
		"<leader>pd",
		vim.lsp.buf.peek_definition,
		"[P]eek [D]efinition"
	)
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

-- sqls
lspconfig.sqls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

require('lspconfig').sqls.setup {
	on_attach = function(client, bufnr)
		require('sqls').on_attach(client, bufnr)
	end
}

local group = vim.api.nvim_create_augroup("FormatSQL", {})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.sql",
	group = group,
	callback = function()
		local file_path = vim.fn.expand "%"
		local file, error = io.open(file_path, "r")
		if not file then
			print("Failed to open file: " .. error)
			return
		end
		local content = file:read("*a")
		file:close()
		-- local file = io.open(vim.fn.expand "%", "w")
		local cmd = "echo \"" .. content .. "\" | sleek -i 4"
		local handle, err = io.popen(cmd, "r")
		if handle then
			local result = handle:read("*a")
			handle:close()
			-- print("Command output:", result)
			local active_file = io.open(vim.fn.expand "%", "w")
			if not active_file then
				print("Failed to open file for writing")
				return
			end
			active_file:write(result)
			active_file:close()
			vim.cmd "e!"
			print("Formatted SQL file: " .. file_path)
		else
			print("Error running command:", err)
		end
	end,
})
