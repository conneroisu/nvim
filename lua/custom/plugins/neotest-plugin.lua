--[=======[
   neotest
   desc: A test runner plugin for Neovim inspired by vim-test 
   author: nvim-neotest 
   url: https://github.com/nvim-neotest/neotest
--]=======]
return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-go",
	},
	opts = {
		-- Can be a list of adapters like what neotest expects,
		-- or a list of adapter names,
		-- or a table of adapter names, mapped to adapter configs.
		-- The adapter will then be automatically loaded with the config.
		adapters = {
			["neotest-python"] = {
				-- Extra arguments for nvim-dap configuration
				-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
				dap = { justMyCode = false },
				-- Command line arguments for runner
				-- Can also be a function to return dynamic values
				args = { "--log-level", "DEBUG" },
				-- Runner to use. Will use pytest if available by default.
				-- Can be a function to return dynamic value.
				runner = "pytest",
				-- Custom python path for the runner.
				-- Can be a string or a list of strings.
				-- Can also be a function to return dynamic value.
				-- If not provided, the path will be inferred by checking for
				-- virtual envs in the local directory and for Pipenev/Poetry configs
				python = "C:\\Users\\Conne\\Documents\\significant-gpt\\Auto-GPT-0.3.1\\agpt-venv\\Scripts\\python.exe",
				-- Returns if a given file path is a test file.
			},
		},
		-- Example for loading neotest-go with a custom config
		-- adapters = {
		--   ["neotest-go"] = {
		--     args = { "-tags=integration" },
		--   },
		-- },

		status = { virtual_text = true },
		output = { open_on_run = true },
		quickfix = {
			open = function()
				if require("lazyvim.util").has("trouble.nvim") then
					vim.cmd("Trouble quickfix")
				else
					vim.cmd("copen")
				end
			end,
		},
	},
	config = function(_, opts)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		if opts.adapters then
			local adapters = {}
			for name, config in pairs(opts.adapters or {}) do
				if type(name) == "number" then
					if type(config) == "string" then
						config = require(config)
					end
					adapters[#adapters + 1] = config
				elseif config ~= false then
					local adapter = require(name)
					if type(config) == "table" and not vim.tbl_isempty(config) then
						local meta = getmetatable(adapter)
						if adapter.setup then
							adapter.setup(config)
						elseif meta and meta.__call then
							adapter(config)
						else
							error("Adapter " .. name .. " does not support setup")
						end
					end
					adapters[#adapters + 1] = adapter
				end
			end
			opts.adapters = adapters
		end

		require("neotest").setup(opts)
	end,
  -- stylua: ignore
  keys = {
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
  },
}
