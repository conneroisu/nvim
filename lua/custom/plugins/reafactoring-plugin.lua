--[=====[
name: Refactoring Plugin
author: ThePrimeagen
url: https://github.com/ThePrimeagen/refactoring.nvim
description: A refactoring plugin based on the Refactoring book by Martin Fowler
tags: ['refactoring', 'fowler', 'book', 'primeagen', 'theprimeagen']
--]=====]
return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
    config = function()
        require("refactoring").setup()
    end
}
