---@module "neogen-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    "danymat/neogen",
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    config = function()
        require('neogen').setup {
            -- snippet_engine = "luasnip",
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = "google_docstrings"
                    }
                },
                go = {
                    template = {
                        annotation_convention = "godoc"
                    }
                },
                javascript = {
                    template = {
                        annotation_convention = "jsdoc"
                    }
                },
                css = {
                    template = {
                        annotation_convention = "xmldoc"
                    }
                },
                lua = {
                    template = {
                        annotation_convention = "emmylua"
                    }
                },
                java = {
                    template = {
                        annotation_convention = "javadoc"
                    }
                },
            }
        }

        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
        vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
        vim.api.nvim_set_keymap("n", "<Leader>nF", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
        vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
    end
}
