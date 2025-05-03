return {
  "saghen/blink.cmp",
  version = 'v1.1.1',
  dependencies = {
    { 'echasnovski/mini.nvim', version = false }
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    fuzzy = {
      prebuilt_binaries = {
        force_version = "v1.1.1"
      },
    },
    sources = {
      default = { "path", "lsp", "snippets", "buffer", "lazydev" },

      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = {
          fallbacks = { "path", "buffer", "snippets" },
        },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
      },
    },
    enabled = function()
      return true
    end,
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 10,
      },

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
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
  },
  opts_extend = { "sources.default" }
}
