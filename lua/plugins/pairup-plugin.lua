return {
  "Piotr1215/pairup.nvim",
  config = function()
    require("pairup").setup({
      provider = "claude",
    })
  end,
}
