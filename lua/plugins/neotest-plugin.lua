return {
  "nvim-neotest/neotest",
  dependencies = {
    {
      "fredrikaverpil/neotest-golang",
      version = "*", -- Optional, but recommended; track releases
    },
    "lawrence-laz/neotest-zig",
    "rouge8/neotest-rust",
    build = function()
      vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
    end,
    "arthur944/neotest-bun",
    "nvim-neotest/neotest-python",
    "nvim-neotest/nvim-nio",
    'thenbe/neotest-playwright',
  },
  opts = {
    log_level = vim.log.levels.TRACE,
    adapters = {
      ["neotest-zig"] = {
        dap = {
          adapter = "lldb",
        },
      },
      ["neotest-playwright"] = {
        options = {
          persist_project_selection = true,
          enable_dynamic_test_discovery = true,
        },
      },
      ["neotest-bun"] = {
      },
      ["neotest-rust"] = {
        dap = {
          adapter = "lldb",
        },
      },
      ["neotest-python"] = {
        dap = { justMyCode = false },
        args = { "--log-level", "DEBUG" },
        runner = "pytest",
        is_test_file = function(file_path)
          return file_path:match("test_.*%.py") or file_path:match(".*_test%.py")
        end,
      },
      ["neotest-go"] = {
        runner = "go test",
        experimental = {
          test_table = true,
        },
        args = { "-count=1", "-timeout=60s", "-v" }
      },
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    quickfix = {
      open = function()
        if require("lazyvim.util").has("trouble.nvim") then
          vim.cmd("Trouble quickfix")
        else
          vim.cmd("copen")
        end
      end,
    },
  },
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+",
            " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if type(name) == "number" then
          if type(config) == "string" then
            config = require(config)
          end
          adapters[#adapters + 1] = config
        elseif config ~= false then
          local adapter = require(name)
          if type(config) == "table" and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif meta and meta.__call then
              adapter(config)
            else
              error("Adapter " .. name .. " does not support setup")
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end

    require("neotest").setup(opts)

    vim.api.nvim_set_keymap("n", "<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>", {
      noremap = true,
      silent = true
    })
  end,
  keys = {
    {
      "<leader>tf",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Run File"
    },
    {
      "<leader>tT",
      function() require("neotest").run.run(vim.loop.cwd()) end,
      desc = "Run All Test Files"
    },
    {
      "<leader>tr",
      function() require("neotest").run.run() end,
      desc =
      "Run Nearest"
    },
    {
      "<leader>ts",
      function() require("neotest").summary.toggle() end,
      desc =
      "Toggle Summary"
    },
    {
      "<leader>to",
      function() require("neotest").output.open({ enter = true, auto_close = true }) end,
      desc =
      "Show Output"
    },
    {
      "<leader>tO",
      function() require("neotest").output_panel.toggle() end,
      desc =
      "Toggle Output Panel"
    },
    {
      "<leader>tS",
      function() require("neotest").run.stop() end,
      desc =
      "Stop"
    },
  },
}
