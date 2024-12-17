---@module "harpoon-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
  "ThePrimeagen/harpoon",
  event = "BufRead",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<space>m", function() harpoon:list():add() end)
    vim.keymap.set("n", "<space>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<A-l>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<A-h>", function() harpoon:list():next() end)
  end
}
