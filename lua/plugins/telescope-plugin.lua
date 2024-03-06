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
    end
}
