--[==============[
   github copilot
   desc: AI pair programmer
   author: github (https:github.com/github)
   url: https:github.com/github/copilot
   tags: ai, github, autocomplete, language-model
--]==============] return {
    "github/copilot.vim",
    config = function()
        vim.g.copilot_filetypes = {
            ["*"] = true
        }
    end
}
