---@module "lsp-zero-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    "VonHeikemen/lsp-zero.nvim",
    event = "BufReadPre",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        {
            'nvimdev/lspsaga.nvim',
            event = "LspAttach",
            config = function()
                local saga = require('lspsaga')
                saga.setup({
                    config = {
                        implement = {
                            enable = true,
                            sign = true,
                            virtual_text = true,
                            priority = 100,
                        },
                        symbol_in_winbar = {
                            color_mode = true,
                            delay = 300,
                            enable = true,
                            folder_level = 1,

                            ignore_patterns = nil,
                            hide_keyword = false,
                            separator = ' › ',
                            show_file = true,
                        }
                    },
                })
            end,
            dependencies = {
                'nvim-treesitter/nvim-treesitter',
                'nvim-tree/nvim-web-devicons',
            }
        },
    },
    config = function()
        local lsp = require("lsp-zero")
        local lspconfig = require "lspconfig"
        local lsp_config_util = lspconfig.util
        local lua_opts = lsp.nvim_lua_ls()
        lspconfig.lua_ls.setup(lua_opts)
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, remap = true }
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, {
                desc = "Format current buffer with LSP",
            })
            vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", {
                buffer = bufnr,
                remap = true,
                desc = "[R]e[n]ame"
            })
            vim.keymap.set("n", "<leader>cf", "<cmd>Lspsaga code_action<CR>", {
                buffer = bufnr,
                remap = true,
                desc = "[C]ode [A]ction"
            })
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {
                buffer = bufnr,
                remap = true,
                desc = "[G]oto [D]efinition"
            })
            vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, {
                buffer = bufnr,
                remap = true,
                desc = "[G]oto [I]mplementation"
            })
            vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end, {
                buffer = bufnr,
                remap = true,
                desc = "Type [D]efinition"
            })
            vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, {
                buffer = bufnr,
                remap = true,
                desc = "Signature Documentation"
            })
            vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, {
                buffer = bufnr,
                remap = true,
                desc = "[G]oto [D]eclaration"
            })
            vim.keymap.set("n", "<leaderawf", function() vim.lsp.buf.add_workspace_folder() end, {
                buffer = bufnr,
                remap = true,
                desc = "[W]orkspace [A]dd Folder"
            })
            vim.keymap.set("n", "<leader>rwf", function() vim.lsp.buf.remove_workspace_folder() end, {
                buffer = bufnr,
                remap = true,
                desc = "[W]orkspace [R]emove Folder"
            })
            vim.keymap.set("n", "<leader>lwr", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, {
                buffer = bufnr,
                remap = true,
                desc = "[W]orkspace [L]ist Folders"
            })
            vim.keymap.set("n", "<leader>dp", function() vim.lsp.buf.peek_definition() end, {
                buffer = bufnr,
                remap = true,
                desc = "[P]eek [D]efinition"
            })
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            require('mason').setup()
        end

        lsp.on_attach(on_attach)
        lsp.setup()
        --  define the property "filetypes" to the map in question, to override the default filetypes of a server.
        local servers = {
            gopls = {
                filetypes = { "go", "gomod" },
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            },
            htmx = {
                filetypes = { "html", "htm", "templ", "jsx", "tsx", "svelte" },
            },
            svelte = {
                filetypes = { "svelte" },
            },
            ts_ls = {},
            -- ltex = {
            --     filetypes = { "tex", "bib", "md", "markdown" },
            -- },
            texlab = {},
            dockerls = {},
            taplo = {},
            emmet_ls = {
                filetypes = { "html", "css", "scss", "javascript", "typescript", "astro", "svelte", "vue", "templ" },
            },
            tailwindcss = {
                filetypes = {
                    "css",
                    "scss",
                    "javascript",
                    "typescript",
                    "astro",
                    "svelte",
                    "html",
                    "vue",
                    "templ"
                }
            },
            terraformls = {
                filetypes = { "terraform" },
            },
            html = {
                filetypes = { "html", "twig", "hbs" },
            },
        }
        local mason_lspconfig = require "mason-lspconfig"
        mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
        mason_lspconfig.setup_handlers {
            function(server_name)
                require("lspconfig")[server_name].setup {
                    capabilities = capabilities,
                    on_attach = lsp.on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }
        local custom_servers = {
            vhdl_ls = {
                config = {
                    root_dir = function(fname)
                        return lsp_config_util.root_pattern('vhdl_ls.toml')(fname)
                    end,
                    name = "vhdl_ls",
                    filetypes = { "vhdl", "vhd" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    auto_start = true,
                },
            },
            veridian = {
                config = {
                    name = "veridian",
                    cmd = { 'veridian' },
                    filetypes = { "v", "verilog" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    root_dir = function(fname)
                        local root_pattern = lsp_config_util.root_pattern("veridian.yml", ".git")
                        local filename = lsp_config_util.path.is_absolute(fname) and fname
                            or lsp_config_util.path.join(vim.loop.cwd(), fname)
                        return root_pattern(filename) or vim.fs.dirname(filename)
                    end,
                    auto_start = true,
                },
            },
            ghdl_ls = {
                config = {
                    name = "ghdl_ls",
                    command = { "ghdl", "--lsp" },
                    filetypes = { "vhdl", "vhd" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    root_dir = function(fname)
                        return lsp_config_util.find_git_ancestor(fname) or vim.fs.dirname(fname)
                    end,
                    auto_start = true,
                },
            },
            basedpyright = {
                config = {
                    name = "basedpyright",
                    filetypes = { "python", "py" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    auto_start = true,
                },
            },
            -- sqls = {
            --     config = {
            --         name = "sqls",
            --         filetypes = { "sql", "mysql", "postgresql", "plpgsql", "psql" },
            --         setup = function(server)
            --             server.config.on_attach = on_attach
            --         end,
            --         on_attach = function(client, bufnr)
            --             require('sqls').on_attach(client, bufnr)
            --         end,
            --         auto_start = true,
            --     },
            -- },
            templ = {
                config = {
                    name = "templ",
                    filetypes = { "templ" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    root_dir = function(fname)
                        return lsp_config_util.root_pattern('go.mod', '.git')(fname)
                    end,
                    auto_start = true,
                },
            },
            -- seltabls = {
            --     filetypes = { "go", "gomod" },
            --     config = {
            --         filetypes = { "go", "gomod" },
            --         cmd = { "seltabls", "lsp" },
            --         name = "seltabls",
            --         setup = function(server)
            --             server.config.on_attach = on_attach
            --         end,
            --         root_dir = function(fname)
            --             return lsp_config_util.root_pattern('go.mod', '.git')(fname)
            --         end,
            --         auto_start = true,
            --         on_attach = on_attach,
            --     },
            -- },
            jdtls = {
                config = {
                    name = "jdtls",
                    filetypes = { "java", "jsp" },
                    command = { "/bin/jdtls" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    root_dir = function(fname)
                        return lsp_config_util.root_pattern('jdtls.ls')(fname)
                    end,
                    auto_start = true,
                },
            },
            -- hdl_checker = {
            --     command = { "hdl_checker", "-fsynopsys", "--lsp" },
            --     config = {
            --         name = "hdl_checker",
            --         filetypes = { "vhdl", "vhd", "verilog", "systemverilog" },
            --         setup = function(server)
            --             server.config.on_attach = on_attach
            --         end,
            --         root_dir = function(fname)
            --             -- will look for the .hdl_checker.config file in parent directory, a
            --             -- .git directory, or else use the current directory, in that order.
            --             local util = require 'lspconfig'.util
            --             return util.root_pattern('.hdl_checker.config')(fname) or util.find_git_ancestor(fname) or
            --             util.path.dirname(fname)
            --         end,
            --         auto_start = true,
            --     },
            -- },
            zls = {
                config = {
                    name = "zls",
                    filetypes = { "zig" },
                    setup = function(server)
                        server.config.on_attach = on_attach
                    end,
                    root_dir = function(fname)
                        return lsp_config_util.root_pattern('zls.json', '.git')(fname)
                    end,
                    auto_start = true,
                },
            },
        }
        -- lspconfig["seltabls"] = {
        --     default_config = custom_servers.seltabls.config,
        --     config = custom_servers.seltabls.config,
        --     setup = function()
        --     end,
        -- }
        for server_name, server_config in pairs(custom_servers) do
            if not lspconfig[server_name] then
                lspconfig[server_name] = {
                    default_config = server_config.config,
                }
            else
                lspconfig[server_name].config = server_config.config
            end
            lspconfig[server_name].setup(server_config.config)
        end
        lspconfig.nil_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "nix", },
            root_dir = function(fname)
                return lsp_config_util.root_pattern('go.mod', '.git')(fname)
            end,
        }
    end,
}
