---@module "dap-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            'leoluz/nvim-dap-go',
            config = function()
                require('dap-go').setup {
                    -- Additional dap configurations can be added.
                    -- dap_configurations accepts a list of tables where each entry
                    -- represents a dap configuration. For more details do:
                    -- :help dap-configuration
                    dap_configurations = {
                        {
                            -- Must be "go" or it will be ignored by the plugin
                            type = "go",
                            name = "Attach remote",
                            mode = "remote",
                            request = "attach",
                        },
                    },
                    -- delve configurations
                    delve = {
                        -- the path to the executable dlv which will be used for debugging.
                        -- by default, this is the "dlv" executable on your PATH.
                        path = "dlv",
                        -- time to wait for delve to initialize the debug session.
                        -- default to 20 seconds
                        initialize_timeout_sec = 20,
                        -- a string that defines the port to start delve debugger.
                        -- default to string "${port}" which instructs nvim-dap
                        -- to start the process in a random available port
                        port = "${port}",
                        -- additional args to pass to dlv
                        args = {},
                        -- the build flags that are passed to delve.
                        -- defaults to empty string, but can be used to provide flags
                        -- such as "-tags=unit" to make sure the test suite is
                        -- compiled during debugging, for example.
                        -- passing build flags using args is ineffective, as those are
                        -- ignored by delve in dap mode.
                        build_flags = "",
                        -- whether the dlv process to be created detached or not. there is
                        -- an issue on Windows where this needs to be set to false
                        -- otherwise the dlv server creation will fail.
                        detached = true
                    },
                }
            end
        }
    },
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
