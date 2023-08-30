--[=====[
   nabla
   desc: ASCII math generator from LaTeX equations
   author: jbyuki (https://github.com/jbyuki)
   url: https://github.com/jbyuki/nabla.nvim 
--]=====]
return {
	"jbyuki/nabla.nvim",
	Event = "VeryLazy",
	config = function()
		require("nabla").enable_virt({
			autogen = true, -- auto-regenerate ASCII art when exiting insert mode
			silent = true, -- silents error messages
		})
	end,
}
