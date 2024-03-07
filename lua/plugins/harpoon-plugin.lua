---@module "harpoon-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    "ThePrimeagen/harpoon",
    config = function()
        -- bind harpoon view all project marks to space + h
        vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", {
            noremap = true,
            silent = true,
            desc = "View all harpoon marks"
        })

        -- bind harpoon navigate next to alt + h
        vim.api.nvim_set_keymap("n", "<A-h>", ":lua require('harpoon.ui').nav_next()<CR>", {
            noremap = true,
            silent = true,
            desc = "Navigate to next harpoon mark"
        })

        -- bind harpoon navigate previous to alt + l
        vim.api.nvim_set_keymap("n", "<A-l>", ":lua require('harpoon.ui').nav_prev()<CR>", {
            noremap = true,
            silent = true,
            desc = "Navigate to previous harpoon mark"
        })

        -- bind harpoon mark / add file to space + m
        vim.api.nvim_set_keymap("n", "<space>m", ":lua require('harpoon.mark').add_file()<CR>", {
            noremap = true,
            silent = true,
            desc = "Add file to harpoon list of files"
        })

        -- Bind harpoon go to first mark to Alt + 1
        vim.api.nvim_set_keymap("n", "<M-1>", ":lua require('harpoon.ui').nav_file(1)<CR>", {
            noremap = true,
            silent = true,
            desc = "Navigate to first harpoon mark"
        })

        -- Bind harpoon go to second mark to Ctrl + 2
        vim.api.nvim_set_keymap("n", "<M-2>", ":lua require('harpoon.ui').nav_file(2)<CR>", {
            noremap = true,
            silent = true,
            desc = "Navigate to second harpoon mark"
        })

        -- Bind harpoon go to third mark to Ctrl + 3
        vim.api.nvim_set_keymap("n", "<M-3>", ":lua require('harpoon.ui').nav_file(3)<CR>", {
            noremap = true,
            silent = true,
            desc = "Navigate to third harpoon mark"
        })

        -- Bind harpoon go to fourth mark to Ctrl + 4
        vim.api.nvim_set_keymap("n", "<C-4>", ":lua require('harpoon.ui').nav_file(4)<CR>", {
            noremap = true,
            silent = true,
            desc = "Navigate to fourth harpoon mark"
        })
    end
}
