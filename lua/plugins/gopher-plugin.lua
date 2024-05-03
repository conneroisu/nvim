return {
    "olexsmir/gopher.nvim",
    event = "BufRead",
    requires = { -- dependencies
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("gopher").setup {
            commands = {
                go = "go",
                gomodifytags = "gomodifytags",
                gotests = "~/go/bin/gotests", -- also you can set custom command path
                impl = "impl",
                iferr = "iferr",
            },
        }

        -- add binding leader + EE to call :GoIfError
        vim.api.nvim_set_keymap("n", "<leader>er", ":GoIfErr<CR>", { noremap = true, silent = true })
    end
}
