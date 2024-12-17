---@module "lspconfig-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
  'neovim/nvim-lspconfig',
  on_attach = function(client, bufnr)
    require('completion').on_attach(client, bufnr)
    require('lsp_signature').on_attach()
  end,
  dependencies = {
    {
      'j-hui/fidget.nvim',
      opts = {}
    },
    "folke/lazydev.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local blink = require("blink.cmp")
    local util = lspconfig.util
    local capabilities = blink.get_lsp_capabilities()

    lspconfig.lua_ls.setup({ capabilities = capabilities, })
    lspconfig.gopls.setup({ capabilities = capabilities, })
    lspconfig.basedpyright.setup({ capabilities = capabilities, })
    lspconfig.tsserver.setup({ capabilities = capabilities, })
    lspconfig.rust_analyzer.setup({ capabilities = capabilities, })
    lspconfig.jsonls.setup({ capabilities = capabilities, })
    lspconfig.yamlls.setup({ capabilities = capabilities, })
    lspconfig.clangd.setup({ capabilities = capabilities, })
    lspconfig.ghdl_ls.setup({ capabilities = capabilities, })
    lspconfig.dockerls.setup {}

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({
                async = true,
                bufnr = args.buf,
                id = client.id,
              })
            end,
          })
        end
      end,
    })
  end,
}
