--[====================[
   name: nvim-scrollbar
   desc: Extensible Neovim Scrollbar Plugin
   author: petertriho (https://github.com/petertriho)
   url: https://github.com/petertriho/nvim-scrollbar
--]====================]
return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup()
  end
}
