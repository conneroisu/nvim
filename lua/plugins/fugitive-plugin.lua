return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb",
  },
  keys = {
    {
      "<leader>hu",
      function()
        vim.cmd("Git")
      end,
      desc = "Git Status (Fugitive)",
    },
  },
}
