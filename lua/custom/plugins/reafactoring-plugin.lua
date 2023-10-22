-- DESCRIPTION: Plugin for refactoring code in Neovim using ThePrimeagen/refactoring.nvim
-- AUTHOR: Conner Ohnesoge
-- LICENSE: MIT
-- VERSION: 1.0.0
return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
    config = function()
        require("refactoring").setup()
    end
}
