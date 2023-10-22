return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    on_attach = function(client, bufnr)
        require('completion').on_attach(client, bufnr)
        require('lsp_signature').on_attach()
    end,
    dependencies = { -- Automatically install LSPs to stdpath for neovim
        {
            'williamboman/mason.nvim',
            config = true
        }, 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {}
        } -- Additional lua configuration, makes nvim stuff amazing!
    }
}
