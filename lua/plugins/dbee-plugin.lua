return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    local dbee_sources = require("dbee.sources")
    require("dbee").setup({
      sources = {
        dbee_sources.EnvSource:new("DBEE_CONNECTIONS"),
        dbee_sources.FileSource:new(vim.fn.stdpath("state") .. "/dbee/persistence.json"),
      },
      extra_helpers = {
        ["postgres"] = {
          ["List All"] = "select * from {{ .Table }}",
        },
      },
    })
  end,
}
