local function get_open_command()
  local is_mac = vim.fn.has('macunix') == 1
  if is_mac then
    return 'open'
  else
    return 'xdg-open'
  end
end
return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  cmd = { "Browse" },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw gx
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gx").setup {
      -- open_browser_app = "thorium-browser", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
      -- open_browser_args = { "--background --password-store=gnome-libsecret" }, -- specify any arguments, such as --background for macOS' "open".
      open_browser_app = get_open_command(),
      open_browser_args = {}, -- specify any arguments, such as --background for macOS' "open".
      handlers = {
        plugin = true,        -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true,        -- open github issues
        brewfile = true,      -- open Homebrew formulaes and casks
        package_json = true,  -- open dependencies from package.json
        search = true,        -- search the web/selection on the web if nothing else is found
        nix = {               -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
          handle = function(mode, line, _)
            if string.find(line, "github:") then
              -- Extract the repo author and name from the line
              local author_repo = require("gx.helper").find(line, mode, "github:([%w%-%.]+/[%w%-%.]+)")
              if author_repo then
                return "https://github.com/" .. author_repo
              end
            end
          end,
        },
        rust = {                   -- custom handler to open rust's cargo packages
          filetype = { "toml" },   -- you can also set the required filetype for this handler
          filename = "Cargo.toml", -- or the necessary filename
          handle = function(mode, line, _)
            local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")
            if crate then
              return "https://crates.io/crates/" .. crate
            end
          end,
        },
        golang = { -- custom handler to open golang's go.mod packages
          filetype = { "go.mod" },
          handle = function(mode, line, _)
            local module = require("gx.helper").find(line, mode, "module%s+(%S+)")
            if module then
              return "https://pkg.go.dev/" .. module
            end
          end,
        },
      },
      handler_options = {
        search_engine = "https://google.com/search?q=",
      },
    }
  end,
}
