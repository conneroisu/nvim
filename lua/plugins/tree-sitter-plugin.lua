---@module "tree-sitter-plugin"
---@author Conner Ohnesorge
---@license WTFPL

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
                load_textobjects = true
            end,
        },
        { "nvim-treesitter/nvim-treesitter-context" },
        { 'nvim-treesitter/playground' }
    },
    cmd = { "TSUpdateSync" },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "c",
            "go",
            "html",
            "javascript",
            "typescript",
            "jsdoc",
            "json",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "ninja",
            "toml",
            "rst",
            "c_sharp",
            "regex",
            "svelte",
            "tsx",
            "vim",
            "vimdoc",
            "yaml",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    },
    config = function(_, opts)
        require 'nvim-treesitter.configs'.setup {
            autotag = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
        local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }
        vim.treesitter.language.register('templ', 'templ')
    end,
}
