return {
  "mfussenegger/nvim-dap",
  config = function()
    require('dap-go').setup()
  end,
  keys = {
    {
      "<leader>gdt",
      function()
        require('dap-go').debug_test()
      end,
      desc = "Debug test",
      mode = "n",
      silent = true,
    },
  },
}
