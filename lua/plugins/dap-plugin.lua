return {
    "mfussenegger/nvim-dap",
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("neodev").setup({
                library = {
                    plugins = { "nvim-dap-ui" },
                    types = true
                }
            })
        end
    },
    optional = true,
    -- stylua: ignore
    config = function()
        local dap = require("dap")
        dap.adapters.nlua = function(callback, config)
            callback({
                type = "server",
                host = config.host or "127.0.0.1",
                port = config.port or 8086
            })
        end
        dap.configurations.lua = { {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance"
        } }
    end
}
