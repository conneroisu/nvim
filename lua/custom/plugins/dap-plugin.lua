--[===[
   dap
   desc: Debug Adapter Protocol client implementation for Neovim
   author: mfussenegger (https://github.com/mfussenegger)
   url: https://github.com/mfussenegger/nvim-dap
--]===]

--[======[
   dap ui
   desc: Debug Adapter Protocol UI 
   author: rcarriga (https://github.com/rcarriga)
   url: https://github.com/rcarriga/nvim-dap-ui
--]======]

return {
	"mfussenegger/nvim-dap",
	Event = "VeryLazy",
	{
		"rcarriga/nvim-dap-ui",
		Event = "VryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
	},
	optional = true,
	-- stylua: ignore
  config = function() 
    local dap = require("dap")
    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
      },
    }
  end,
}
