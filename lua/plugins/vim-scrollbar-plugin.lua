---@module "vim-scrollbar-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
  "petertriho/nvim-scrollbar",
  event = "BufWinEnter",
  config = function()
    require("scrollbar").setup()
  end
}
