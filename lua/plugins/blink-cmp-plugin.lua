return {
  "saghen/blink.cmp",
  version = 'v0.7.6',
  opts = {
    debug = true,
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
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
