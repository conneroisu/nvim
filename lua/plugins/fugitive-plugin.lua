return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb",
  },
  config = function()
    -- bind leader + h + u to open Git from fugitive in normal mode
    vim.api.nvim_set_keymap("n", "<leader>hu", "<cmd>Git<cr>", {
      desc = "Git"
    })
  end
}
