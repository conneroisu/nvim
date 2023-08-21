--[=========[
   telescope
   desc: Fuzzy Finder
   author: nvim-telescope 
   url: https://github.com/nvim-telescope/telescope.nvim
--]=========]

--[==============[
   yaml-companion 
   athor: someone stole my name
   url: https://github.com/someone-stole-my-name/yaml-companion.nvim
--]==============]

--[==================[
   Telscope / Project
   desc: Fuzzy finder for files, buffers, git, grep, etc
   author: nvim-telescope <github.com/nvim-telescope>
   url: https://github.com/nvim-telescope/telescope.nvim
--]==================]

--[============[
   telscope coc
   desc: coc implementation for telescope
   author: fannheyward (https://github.com/fannheyward)
   url: https://github.com/fannheyward/telescope-coc.nvim
--]============]

return {
	"nvim-telescope/telescope.nvim",
	"fannheyward/telescope-coc.nvim",
	"nvim-telescope/telescope-project.nvim",
	"LinArcX/telescope-command-palette.nvim", --Telscope command_palette
	"someone-stole-my-name/yaml-companion.nvim",
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
	},
	"gbrlsnchs/telescope-lsp-handlers.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	depts = {
		"neovim/nvim-lspconfig",
		"LinArcX/telescope-command-palette.nvim", --Telscope command_palette
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("coc")
		telescope.load_extension("projects")
		telescope.load_extension("yaml_schema")
require'telescope'.load_extension('project')
		telescope.setup({

			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},

				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},

				project = {
					hidden_files = true, -- default: false
					theme = "dropdown",
					order_by = "asc",
					search_by = "title",
					sync_with_nvim_tree = true, -- default false
					-- default for on_project_selected = find project files
					-- make sure this override the one in telescope.nvim
					on_project_selected = function(prompt_bufnr)
						-- Do anything you want in here. For example:
						require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
						vim.cmd(":Oil .")
					end,
				},
			},
		})
	end,
}
