return {
  "tpope/vim-fugitive",
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
