--[=========[
   codestats
	 desc: code stats embeded into the text editor
	 author: liljaylj
	 url: https://github.com/liljaylj/codestats.nvim
--]=========]

-- Lazy.nvim
return {
	"liljaylj/codestats.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "TextChanged", "InsertEnter" },
	cmd = { "CodeStatsXpSend", "CodeStatsProfileUpdate" },
	config = function()
		require("codestats").setup({
			username = "conneroisu", -- needed to fetch profile data
			base_url = "https://codestats.net", -- codestats.net base url
			api_key = "SFMyNTY.WTI5dWJtVnliMmx6ZFE9PSMjTWpBME16WT0.EEDbBaR-KF-5lmdldz3ax8HJCGVhd2UGTcXnQxssWiw",
			send_on_exit = true, -- send xp on nvim exit
			send_on_timer = true, -- send xp on timer
			timer_interval = 1000, -- timer interval in milliseconds (minimum 1000ms to prevent DDoSing codestat.net servers)
			curl_timeout = 5, -- curl request timeout in seconds
		})
	end,
}
