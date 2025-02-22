local function setup_python_dap()
  -- Try to require the module
  local ok, dap_python = pcall(require, "dap-python")
  if not ok then return false end
  -- Check debugpy availability
  local handle = io.popen("python3 -m debugpy --version 2>&1")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result:match("^%d+%.%d+%.%d+") then
      dap_python.setup("python3")
      return true
    end
  end
  return false
end
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-dap-virtual-text").setup({
      enabled = true,
    })

    ---@diagnostic disable-next-line: missing-fields
    require("dapui").setup({})

    if not setup_python_dap() then
      vim.notify("Python debug adapter not found. Please install debugpy.")
    end
  end,
  keys = {
  },
}
