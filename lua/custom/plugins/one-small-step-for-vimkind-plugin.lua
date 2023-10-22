--[===========================[
   one small step for vim kind
   desc: Debug Adapter Protocol for Neovim
   author: jbyuki
   url: https://github.com/jbyuki/one=one-small-step-for-vimkind
--]===========================]
return {
	"jbyuki/one-small-step-for-vimkind",
	-- stylua: ignore
	keys = {
		{ "<leader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
		{ "<leader>dal", function() require("osv").run_this() end,              desc = "Adapter Lua" },
	},
	dependencies = { "mfussenegger/nvim-dap" },
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
