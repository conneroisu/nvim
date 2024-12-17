return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      "lazy.nvim",
      "LazyVim",
      { path = "LazyVim",            words = { "LazyVim" } },
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}
