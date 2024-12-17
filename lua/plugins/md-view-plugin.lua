-- init.lua
return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  config = function()
    require "conneroisu.markdown"
  end,
}
