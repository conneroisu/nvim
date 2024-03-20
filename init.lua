--@module "init"
---@author Conner Ohnesorge
---@license WTFPL

--  (otherwise wrong leader will be used)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
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

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--- This function sets up the keymaps for the LSP, and also sets up the LSP specific commands.
local on_attach = function(it, bufnr)
	-- Function that lets us more easily define mappings specific for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, {
			buffer = bufnr,
			desc = desc,
		})
	end
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>cf", ":Lspsaga code_action<CR>", "[C]ode [A]ction")
	nmap("<leader>pd", ":Lspsaga peek_definition<CR>", "[P]eek [D]efinition")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "[D]ocument [S]ymbols")
	nmap("<leader>ws", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
		"[W]orkspace [S]ymbols")
	-- See `:help K` for why this keymap
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {
		desc = "Format current buffer with LSP",
	})
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
if not lspconfig.hdl_checker then
	require("lspconfig/configs").hdl_checker = {
		default_config = {
			cmd = { "hdl_checker", "--lsp" },
			filetypes = { "vhdl", "verilog", "systemverilog", "vhd" },
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
			end,
			settings = {},
		},
	}
end
if not lspconfig.ghdl_ls then
	require("lspconfig/configs").ghdl_ls = {
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
vim.filetype.add {
	extension = {
		templ = "templ",
	},
}

-- Make sure we have a Tree-Sitter Grammar for the Language
local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
treesitter_parser_config.templ = treesitter_parser_config.templ
    or {
	    install_info = {
		    url = "https://github.com/vrischmann/tree-sitter-templ.git",
		    files = { "src/parser.c", "src/scanner.c" },
		    branch = "master",
	    },
    }

-- Register the LSP as a Config
local configs = require "lspconfig.configs"
vim.treesitter.language.register("templ", "templ")
if not configs.templ then
	configs.templ = {
		default_config = {
			cmd = { "templ", "lsp" },
			filetypes = { "templ" },
			root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
			settings = {},
		},
	}
end

-- Activate the Tailwind-Lsp for `.templ` files
require("lspconfig").tailwindcss.setup {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "templ", "html", "css", "scss", "javascript", "typescript", "astro", "svelte", "vue" },
	root_dir = require("lspconfig.util").root_pattern("go.mod", ".git", "tailwind.config.js", "postcss.config.js", "tailwind.config.cjs"),
	settings = {},
	on_attach = on_attach,
	capabilities = capabilities,
}

local util = require "lspconfig/util"
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
			return util.root_pattern('vhdl_ls.toml')(fname)
		end,
	}
}

require('lspconfig').sqls.setup {
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
