return {
  "saghen/blink.cmp",
  version = 'v0.11.0',
  dependencies = {
    { 'echasnovski/mini.nvim', version = false }
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { "path", "lsp", "snippets", "buffer", "lazydev" },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = {
          score_offset = 2,
        },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
      },
    },
    completion = {
      menu = {
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
        draw = {
          columns = {
            { "label",     "label_description", gap = 1 },
            { "kind_icon", "kind" }
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- Optionally, you may also use the highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            }
          },
        },
      },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" }
}
