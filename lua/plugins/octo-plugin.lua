return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require "octo".setup()

    -- map leader + h + i to open the github issues in normal mode
    vim.keymap.set("n", "<leader>hi", ":Octo issue list<CR>", {
      desc = "Open Github Issues"
    })

    -- bind leader + g + h to open the Octo github issue list in normal mode
    vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>:Octo issue list<CR>", {
      desc = "Open the Octo issue list"
    })
  end
}
