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
            'williamboman/mason.nvim',
            config = true
        },
        'williamboman/mason-lspconfig.nvim',
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {}
        }
    }
}
