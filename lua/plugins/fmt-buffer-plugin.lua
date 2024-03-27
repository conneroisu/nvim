return {
    "acro5piano/nvim-format-buffer",
    config = function()
        local nvim_format_buffer = require("nvim-format-buffer")
        nvim_format_buffer.setup({
            -- If true, print an error message if command fails. default: false
            verbose = false,
            format_rules = {
                
                { pattern = { "*.sql" }, command = "sleek" },
                { pattern = { "*.tex" }, command = "untex format" },
            },
        })
        -- sql
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = { "*.sql" },
            callback = function()
                nvim_format_buffer.format_whole_file("sleek")
                print("Formatted!")
            end,
        })
        -- tex
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = { "*.tex" },
            callback = function()
                nvim_format_buffer.format_whole_file("untex format")
                print("Formatted!")
            end,
        })
    end
}
