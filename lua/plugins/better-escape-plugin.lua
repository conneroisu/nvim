return {
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup {
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            -- These can all also be functions
            k = "<Esc>",
            -- j = "<Esc>",
          },
        },
      },
    }
  end,
}
