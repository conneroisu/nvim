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
            config = function(_, opts)
                require("project_nvim").setup(opts)
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
        vim.keymap.set('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", {
            desc = '[F]ind [F]iles'
        })

        -- See `:help telescope.builtin`
        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, {
            desc = '[?] Find recently opened files'
        })

        vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, {
            desc = '[ ] Find existing buffers'
        })

        vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
            desc = 'Search [G]it [F]iles'
        })
        vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {
            desc = '[S]earch [F]iles'
        })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {
            desc = '[S]earch [H]elp'
        })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {
            desc = '[S]earch current [W]ord'
        })
        vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {
            desc = '[S]earch by [G]rep'
        })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {
            desc = '[S]earch [D]iagnostics'
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
