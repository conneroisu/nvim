return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        -- disable rtp plugin, as we only need its queries for mini.ai
        -- In case other textobject modules are enabled, we will load them
        -- once nvim-treesitter is loaded
        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        vim.g.load_textobjects = true
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup {
          enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
          multiwindow = false,      -- Enable multiwindow support.
          max_lines = 8,            -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20,     -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
      end,
    },
    { 'nvim-treesitter/playground' }
  },
  cmd = { "TSUpdateSync" },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>",      desc = "Decrement selection", mode = "x" },
  },
  opts = {
    auto_install = true,
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "zig",
      "lua",
      "python",
      "rust",
      "tsx",
      "typescript",
      "vimdoc",
      "vim",
      "c_sharp",
      "astro",
      "ninja",
      "bash",
      "css",
      "rst",
      "toml",
      "markdown",
      "proto",
      "printf",
      "hyprlang",
      "json",
      "php",
      "regex",
      "templ",
      "sql",
      "yaml",
      "html",
      "javascript",
      "vhdl",
      "verilog",
      "jsonc",
      "zig",
      "svelte",
      "nix",
      "ocamllex",
      "ocaml",
      "luadoc",
      "kotlin",
      "jsdoc",
      "go",
      "dockerfile",
      "asm",
      "arduino",
      "bash",
      "cmake",
      "gitcommit",
      "latex",
      "requirements",
      "todotxt",
      "verilog",
      "vhs",
      "yaml",
      "templ",
    },
    autotag = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "markdown" },
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  },
  config = function(_, opts)
    ---@diagnostic disable-next-line: missing-fields
    require 'nvim-treesitter.configs'.setup(opts)
    -- ---@class TreesitterParserConfig
    -- local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    -- treesitter_parser_config.templ = {
    --   install_info = {
    --     url = "https://github.com/vrischmann/tree-sitter-templ.git",
    --     files = { "src/parser.c", "src/scanner.c" },
    --     branch = "master",
    --   },
    -- }
    -- vim.treesitter.language.register('templ', 'templ')
  end,
}
