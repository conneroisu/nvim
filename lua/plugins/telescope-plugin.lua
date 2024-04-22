---@module "telescope-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        {
            'nvim-lua/plenary.nvim',
            config = function()
                require('telescope').setup()
                require('telescope').load_extension('project')
            end,
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end
            }
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build =
            'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
        },
        {
            "ahmedkhalf/project.nvim",
            opts = {},
            config = function()
                require("project_nvim").setup {
                    -- Manual mode doesn't automatically change your root directory, so you have
                    -- the option to manually do so using `:ProjectRoot` command.
                    manual_mode = false,

                    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
                    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
                    -- order matters: if one is not detected, the other is used as fallback. You
                    -- can also delete or rearangne the detection methods.
                    detection_methods = { "lsp", "pattern" },

                    -- All the patterns used to detect root dir, when **"pattern"** is in
                    -- detection_methods
                    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

                    -- Table of lsp clients to ignore by name
                    -- eg: { "efm", ... }
                    ignore_lsp = {},

                    -- Don't calculate root dir on specific directories
                    -- Ex: { "~/.cargo/*", ... }
                    exclude_dirs = {},

                    -- Show hidden files in telescope
                    show_hidden = false,

                    -- When set to false, you will get a message when project.nvim changes your
                    -- directory.
                    silent_chdir = true,

                    -- What scope to change the directory, valid options are
                    -- * global (default)
                    -- * tab
                    -- * win
                    scope_chdir = 'global',

                    -- Path where project.nvim will store the project history for use in
                    -- telescope
                    datapath = vim.fn.stdpath("data"),
                }
                require("telescope").load_extension("projects")
            end,
            keys = {
                { "<leader>gp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
            },
        },
        {
            'nvim-lua/popup.nvim'
        },
        {
            'nvim-telescope/telescope-media-files.nvim',
            config = function()
                require('telescope').load_extension('media_files')
            end,
        }
    },
    config = function()
	local built_in = require "telescope.builtin"
        -- bind Control + o to open recent files in normal mode
        vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope oldfiles<CR>", {
            noremap = true,
            silent = true,
            desc = "Open Recent Files"
        })
        -- map telescope live_grep to leader + l + g
        vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", {
            desc = "Open Telescope Live Grep"
        })
        -- bind leader + f + f to open telescope in normal mode for files
        vim.keymap.set('n', '<leader>ff', built_in.find_files, {
            desc = '[F]ind [F]iles'
        })
        -- See `:help telescope.builtin`
        vim.keymap.set('n', '<leader>?', built_in.oldfiles, {
            desc = '[?] Find recently opened files'
        })
        vim.keymap.set('n', '<leader><space>', built_in.buffers, {
            desc = '[ ] Find existing buffers'
        })
        vim.keymap.set('n', '<leader>gf', built_in.git_files, {
            desc = 'Search [G]it [F]iles'
        })
        vim.keymap.set('n', '<leader>sf', built_in.find_files, {
            desc = '[S]earch [F]iles'
        })
        vim.keymap.set('n', '<leader>sh', built_in.help_tags, {
            desc = '[S]earch [H]elp'
        })
        vim.keymap.set('n', '<leader>sw', built_in.grep_string, {
            desc = '[S]earch current [W]ord'
        })
        vim.keymap.set('n', '<leader>sg', built_in.live_grep, {
            desc = '[S]earch by [G]rep'
        })
        vim.keymap.set('n', '<leader>sd', built_in.diagnostics, {
            desc = '[S]earch [D]iagnostics'
        })
        vim.keymap.set('n', '<leader>gr', built_in.lsp_references, {
            desc = '[G]oto [R]eferences'
        })
        vim.keymap.set('n', '<leader>sr', built_in.resume, {
            desc = '[R]esume [S]earch'
        })
        vim.keymap.set('n', '<leader>ds', built_in.lsp_document_symbols, {
            desc = '[D]ocument [S]ymbols'
        })
        vim.keymap.set('n', '<leader>ws', built_in.lsp_workspace_symbols, {
            desc = '[W]orkspace [S]ymbols'
        })
        -- bind leader + g + p to open telescope projects in normal mode
        vim.api.nvim_set_keymap("n", "<leader>gp", ":Telescope projects<CR>", {
            desc = "Open Telesope projects "
        })
        -- bind space + space to open telescope in normal mode for files
        vim.api.nvim_set_keymap("n", "<space><space>", ":Telescope find_files<CR>", {
            noremap = true,
            silent = true,
            desc = "Open Files for Project using Telescope"
        })
    end
}
