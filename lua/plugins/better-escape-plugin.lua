return {
  "max397574/better-escape.nvim",
  config = function()
    -- lua, default settings
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
