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
    end
}
