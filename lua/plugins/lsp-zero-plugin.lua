return {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        local lsp = require("lsp-zero")
        lsp.preset("recommended")
        -- lsp.nvim_workspace()
        local lua_opts = lsp.nvim_lua_ls()
        require("lspconfig").lua_ls.setup(lua_opts)
        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = true }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

            -- set the scroll off of the buffer when lsp is attached to said buffer to 8
            vim.o.scrolloff = 8
            -- set hybrid line numbers where the actual line number is at the current line and the relative line numbers everywhere else
            -- vim.cmd("set number relativenumber")
            vim.o.relativenumber = true
            vim.o.number = true

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            require('mason').setup()
            local mason_lspconfig = require 'mason-lspconfig'
        end)
        lsp.setup()
    end,
}
