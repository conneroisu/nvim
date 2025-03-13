return {
  "petertriho/nvim-scrollbar",
  event = "BufWinEnter",
  config = function()
    require("scrollbar").setup()
  end
}
