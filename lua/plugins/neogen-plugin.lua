return {
  "danymat/neogen",
  event = "BufRead",
  config = function()
    require('neogen').setup {
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
