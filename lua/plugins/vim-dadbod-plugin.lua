---@module "vim-dadbod-plugin"
---@author "Conner Ohnesorge"
---@license WTFPL

local sql_ft = { "sql", "mysql", "pgsql", "sqlite", "plsql", "pl", "pls", "psql", "db2", "oracle", "teradata", "firebird", "maxdb", "mssql", "sybase", "informix", "ingres", "db2" }
return {
	"tpope/vim-dadbod",
	dependencies = {
		{
			"kristijanhusak/vim-dadbod-completion",
			dependencies = "vim-dadbod",
			ft = sql_ft,
			init = function()
				vim.api.nvim_create_autocmd("FileType", {
					pattern = sql_ft,
					callback = function()
						local cmp = require("cmp")

						-- global sources
						---@param source cmp.SourceConfig
						local sources = vim.tbl_map(function(source)
							return { name = source.name }
						end, cmp.get_config().sources)

						-- add vim-dadbod-completion source
						table.insert(sources, { name = "vim-dadbod-completion" })

						-- update sources for the current buffer
						cmp.setup.buffer({ sources = sources })
					end,
				})
			end,
		},
		{
			"kristijanhusak/vim-dadbod-ui",
			cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
			dependencies = "vim-dadbod",
			keys = {
				{ "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
			},
			init = function()
				local data_path = vim.fn.stdpath("data")

				vim.g.db_ui_auto_execute_table_helpers = 1
				vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
				vim.g.db_ui_show_database_icon = true
				vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
				vim.g.db_ui_use_nerd_fonts = true
				vim.g.db_ui_use_nvim_notify = true

				vim.g.db_ui_execute_on_save = false
			end,
		},
	},
	cmd = "DB",
}
