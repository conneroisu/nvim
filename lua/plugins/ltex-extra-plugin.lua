return {
   "barreiroleo/ltex_extra.nvim",
   ft = { "markdown", "tex" },
   dependencies = { "neovim/nvim-lspconfig" },
   -- yes, you can use the opts field, just I'm showing the setup explicitly
   config = function()
      your_capabilities = vim.lsp.protocol.make_client_capabilities()
      require("ltex_extra").setup {
         server_opts = {
            capabilities = your_capabilities,
            on_attach = function(client, bufnr)
               -- your on_attach process
            end,
            settings = {
               ltex = {}
            }
         },
      }
   end
}
