---@module "vim-scrollbar-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup()
  end
}
