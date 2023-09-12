--[===[
   oil
   desc: File Explorer in Buffer
   author: Stevearc (https://github.com/stevearc)
   url: https://github.com/stevearc/oil.nvim
--]===] return {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("oil").setup({
            -- Id is automatically added at the beginning, and name at the end
            -- See :help oil-columns
            columns = {"icon" -- "permissions"
                ,"size", --"mtime",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
                buflisted = false,
                bufhidden = "hide"
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "n"
            },
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
            default_file_explorer = true,
            -- Restore window options to previous values when leaving an oil buffer
            restore_win_options = true,
            -- Skip the confirmation popup for simple operations
            skip_confirm_for_simple_edits = false,
            -- Deleted files will be removed with the `trash-put` command.
            delete_to_trash = false,
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            prompt_save_on_select_new_entry = true,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden"
            },
            show_hidden = true;
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = true,
    })
    end,
    }
