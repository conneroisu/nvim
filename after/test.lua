---@module "after/test"
---@author Conner Ohnesorge
---@license WTFPL


vim.keymap.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end)
