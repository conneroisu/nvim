return {

    'ray-x/sad.nvim',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    config = function()
        require("sad").setup {}
    end,

}
