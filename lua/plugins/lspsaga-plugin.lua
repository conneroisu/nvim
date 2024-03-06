return {
    'nvimdev/lspsaga.nvim',
    config = function()
        local ls = require('lspsaga')
        ls.setup({
            show_server_name = true,
        })
        ls.open_cmd = "!google-chrome"
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'      -- optional
    }
}
