return {
  "saghen/blink.cmp",
  version = 'v0.7.6',
  dependencies = {
    { 'echasnovski/mini.nvim', version = false }
  },
  opts = {
    debug = true,
    sources = {
      default = { "path", "lsp", "snippets", "buffer", "lazydev" },
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = {
          fallback_for = { "lazydev" },
          score_offset = 2,
        },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", },
      },
    },
    completion = {
      menu = {
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
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
      },
    },
    signature = { enabled = true }
  },
  config = function(_, opts)
    require('blink.cmp').setup(opts)
  end,
}
