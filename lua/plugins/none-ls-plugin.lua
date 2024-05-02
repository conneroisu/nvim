return {
    "nvimtools/none-ls.nvim",
    event = "BufReadPre",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = { null_ls.builtins.formatting.emacs_vhdl_mode }
        })
    end
}
