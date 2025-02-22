return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local dap, ui = require("dap"), require("dapui")
    local go = require("dap-go")

    ui.setup({})
    go.setup({})
    require("nvim-dap-virtual-text").setup({
      enabled = true,
    })

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
    vim.keymap.set("n", "<leader>bt", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>gdt", go.debug_test)
    vim.keymap.set("n", "<leader>gdb", dap.run_to_cursor)
    vim.keymap.set("n", "<F7>", dap.step_into)
    vim.keymap.set("n", "<F8>", dap.step_over)
    vim.keymap.set("n", "<F9>", dap.step_out)
  end,
}
