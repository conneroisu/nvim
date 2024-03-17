return {
    "jmbuhr/otter.nvim",
    config = function()
        local otter = require 'otter'
        otter.setup {
            lsp = {
                hover = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                },
                diagnostic_update_events = { "TextChanged" },
            },
            buffers = {
                set_filetype = true,
                write_to_disk = true,
            },
            strip_wrapping_quote_characters = { "'", '"', "`" },
            handle_leading_whitespace = false,
        }

        local languages = { 'python', 'lua', "typescript", "go", "json" }

        -- enable completion/diagnostics
        local completion = true
        local diagnostics = true
        -- treesitter query to look for embedded languages
        -- uses injections if nil or not set
        local tsquery = nil

        otter.activate(languages, completion, diagnostics, tsquery)
    end
}
