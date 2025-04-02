return {
  "chrisgrieser/nvim-scissors",
  event = "VeryLazy",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    snippetDir = vim.fn.stdpath("config") .. "/snippets",
  }
}
