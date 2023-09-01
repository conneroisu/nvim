--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = '\\'
vim.g.maplocalleader = ' '
-- bind leader + m to open oil file explorer in normal mode
vim.api.nvim_set_keymap("n", "<leader>m", ":Oil<CR>", {
    noremap = true,
    silent = true
})

-- Bind J and K in visual mode to move the seslection up and down respectively
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move visual selection down"
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move visual selection up"
})
-- Map J in normal mode to join lines by staying at the current postiion
vim.keymap.set("n", "J", "mzJ`z", {
    desc = "Join lines"
})
-- set leader + p to "\"_dP allows for pasting without losing yanked text
vim.api.nvim_set_keymap("x", "<leader>p", "\"_dP", {
    noremap = true,
    silent = true
})
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn
        .system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
            lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { 'folke/neodev.nvim', init = function() require('neodev').setup() end },
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',  -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        on_attach = function(client, bufnr)
            require('completion').on_attach(client, bufnr)
            require('lsp_signature').on_attach()
        end,
        dependencies = { -- Automatically install LSPs to stdpath for neovim
            {
                'williamboman/mason.nvim',
                config = true
            }, 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {}
            }, -- Additional lua configuration, makes nvim stuff amazing!
        }
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {                                    -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',                         -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets' }
    },                                                      -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        opts = {}
    },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = {
                    text = '+'
                },
                change = {
                    text = '~'
                },
                delete = {
                    text = '_'
                },
                topdelete = {
                    text = '‾'
                },
                changedelete = {
                    text = '~'
                }
            },
            on_attach = function(bufnr)
                -- vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gsn', require('gitsigns').next_hunk, {
                    buffer = bufnr,
                    desc = '[G]o to [N]ext Hunk'
                })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, {
                    buffer = bufnr,
                    desc = '[P]review [H]unk'
                })
            end
        }
    },
    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'onedark'
        end
    },
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'onedark',
                component_separators = '|',
                section_separators = ''
            }
        }
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false
        }
    }, -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        opts = {}
    },
    {
        import = 'custom.plugins'
    }
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
    silent = true
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true
})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true
})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*'
})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, {
    desc = '[?] Find recently opened files'
})

-- map telescope live_grep to leader + l + g
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", {
    desc = "Open Telescope Live Grep"
})

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {
    desc = '[F]ind [F]iles'
})
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, {
    desc = '[ ] Find existing buffers'
})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false
    })
end, {
    desc = '[/] Fuzzily search in current buffer'
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

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>'
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner'
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner'
            }
        }
    }
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
    desc = 'Go to previous diagnostic message'
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
    desc = 'Go to next diagnostic message'
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
    desc = 'Open floating diagnostic message'
})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostics list'
})
vim.keymap.set("n", "<leader>u", "<Cmd>UrlView<CR>", {
    desc = "View buffer URLs"
})
vim.keymap.set("n", "<leader>U", "<Cmd>UrlView packer<CR>", {
    desc = "View Packer plugin URLs"
})
-- map telescope live_grep to leader + l + g
vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<CR>", {
    desc = "Open Telescope Live Grep"
})

-- tabs
vim.api.nvim_set_keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", {
    desc = "Last Tab"
})
vim.api.nvim_set_keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", {
    desc = "First Tab"
})
vim.api.nvim_set_keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", {
    desc = "New Tab"
})
vim.api.nvim_set_keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", {
    desc = "Next Tab"
})
vim.api.nvim_set_keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", {
    desc = "Close Tab"
})
vim.api.nvim_set_keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", {
    desc = "Previous Tab"
})
-- buffers
vim.api.nvim_set_keymap("n", "<C-Left>", "<cmd>bprevious<cr>", {
    desc = "Prev buffer"
})
vim.api.nvim_set_keymap("n", "<C-Right>", "<cmd>bnext<cr>", {
    desc = "Next buffer"
})
vim.api.nvim_set_keymap("n", "[b", "<cmd>bprevious<cr>", {
    desc = "Prev buffer"
})
vim.api.nvim_set_keymap("n", "]b", "<cmd>bnext<cr>", {
    desc = "Next buffer"
})
-- Bind redo to Ctrl + Y
vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>redo<cr>", {
    desc = "Redo"
})
-- Bind the previous file to alt+left like in a browser.
vim.api.nvim_set_keymap("n", "<A-Left>", ":edit #<cr>", {
    silent = true
})

-- bind leader + x + L to open location list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", {
    desc = "Location List (Trouble)"
})

-- bind leader + x + Q to open quickfix list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", {
    desc = "Quickfix List (Trouble)"
})

-- bind leader + u + u to open undotree in normal mode
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)

-- bind <leader> + x + x to open document diagnostics in normal mode
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", {
    desc = "Document Diagnostics (Trouble)"
})
-- bind <leader> + x + w to open workspace diagnostics
vim.api.nvim_set_keymap("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", {
    desc = "Workspace Diagnostics (Trouble)"
})
-- bind leader + g + h to open the Octo github issue list in normal mode
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>:Octo issue list<CR>", {
    desc = "Open the Octo issue list"
})
-- bind leader + w to open the URL view
vim.keymap.set("n", "<leader>w", "<Cmd>UrlView<CR>", {
    desc = "View buffer URLs"
})

-- lazy
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>:Lazy<cr>", {
    desc = "Lazy"
})
--[=====[
-- Netrw
--]=====]
-- Bind netrw to <leader>M at 25 width
vim.api.nvim_set_keymap("n", "<leader>M", ":Lexplore<CR> :vertical resize 25<CR>", {
    noremap = true,
    silent = true
})

--[=======[
   Neotest
--]=======]
vim.api.nvim_set_keymap("n", "<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>", {
    noremap = true,
    silent = true
})

vim.cmd(":command Wq wq")
vim.cmd(":command VS vs")
vim.cmd(":command Vs vs")
vim.cmd(":command W w")
vim.cmd(":command Q q")

-- bind Control + o to open recent files in normal mode
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope oldfiles<CR>", {
    noremap = true,
    silent = true
})
-- Open file in Obsidian vault
-- macos
vim.cmd([[command! -nargs=0 IO execute "silent !open 'obsidian://open?vault=SecondBrain&file=" . expand('%:t:r') . "'"]])
vim.api.nvim_set_keymap("n", "<leader>io", ":IO<CR>", {
    noremap = true,
    silent = true,
    desc = "Open in Obsidian (MacOS)"
})

vim.api.nvim_set_keymap("n", "<leader>hu", "<cmd>Git<cr>", {
    desc = "Git"
})

-- bind the leader + u + n to dismiss all notifications in normal mode
vim.api.nvim_set_keymap("n", "<leader>un", "<cmd>lua require('notify').dismiss({silent = true, pending = true})<cr>", {
    desc = "Dismiss all Notifications"
})
-- set leader key + c + o to toggle comments in normal and visual mode
vim.api.nvim_set_keymap("n", "<leader>co", "<cmd>CommentToggle<cr>", {
    desc = "Comment Toggle"
})
-- bind leader + c + o to toggle comments in visual mode
vim.api.nvim_set_keymap("v", "<leader>co", ":'<,'>CommentToggle<cr>", {
    desc = "Visual Comment Toggle"
})
-- map leader + x + x to toggle the document diagnostics from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", {
    desc = "Document Diagnostics (Trouble)"
})
-- map leader + x + X to toggle the workspace diagnostics from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", {
    desc = "Workspace Diagnostics (Trouble)"
})
-- bind leader + x + L to toggle the loclist from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", {
    desc = "Location List (Trouble)"
})
-- bind leader + x + Q to toggle the quickfix list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", {
    desc = "Quickfix List (Trouble)"
})
-- bind leader + a + g to generate a github commit message from the git diff in normal mode
vim.api.nvim_set_keymap("n", "<leader>ag", ":NeoAIShortcut gitcommit<CR>", {
    desc = "Generate a git diff commit message."
})
-- bind leader + u + u to toggle the undo tree view in normal mode
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, {
    desc = "Open Undo Tree"
})
-- bind leader + g + p to open telescope projects in normal mode
vim.api.nvim_set_keymap("n", "<leader>gp", ":Telescope projects<CR>", {
    desc = "Open Telesope projects "
})
-- bind leader + e to open the init.lua file in normal mode
vim.api.nvim_set_keymap("n", "<leader>e", ":e $MYVIMRC<CR>", {
    noremap = true,
    silent = true
})
-- bind leader + m to open oil file explorer in normal mode
vim.api.nvim_set_keymap("n", "<leader>m", ":Oil<CR>", {
    noremap = true,
    silent = true
})

-- bind shift + h to move to the start of the line in normal mode
vim.api.nvim_set_keymap("n", "<C-h>", "^", {
    noremap = true,
    silent = true
})
-- bind shift + l to move to the end of the line in normal mode
vim.api.nvim_set_keymap("n", "<C-l>", "$", {
    noremap = true,
    silent = true
})

-- Move Lines
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", {
    desc = "Move down"
})
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", {
    desc = "Move up"
})
vim.api.nvim_set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", {
    desc = "Move down"
})
vim.api.nvim_set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", {
    desc = "Move up"
})
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", {
    desc = "Move down"
})
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", {
    desc = "Move up"
})

vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>e #<cr>", {
    desc = "Switch to Other Buffer"
})
vim.api.nvim_set_keymap("n", "<leader>`", "<cmd>e #<cr>", {
    desc = "Switch to Other Buffer"
})

vim.api.nvim_set_keymap("n", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("x", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("o", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("n", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
vim.api.nvim_set_keymap("x", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
vim.api.nvim_set_keymap("o", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", {
    desc = "Remove Indent"
})
vim.api.nvim_set_keymap("v", ">", ">gv", {
    desc = "Add Indent"
})

-- new file
vim.api.nvim_set_keymap("n", "<leader>fn", "<cmd>enew<cr>", {
    desc = "[N]ew [F]ile"
})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>lopen<cr>", {
    desc = "Location List"
})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>copen<cr>", {
    desc = "Quickfix List"
})

-- floating terminal
local lazyterm = function()
    Util.float_term(nil, {
        cwd = Util.get_root()
    })
end

-- Terminal vim.api.nvim_set_keymappings
vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n>", {
    desc = "Enter Normal Mode"
})
vim.api.nvim_set_keymap("t", "<S-C-h>", "<cmd>wincmd h<cr>", {
    desc = "Go to left window"
})
vim.api.nvim_set_keymap("t", "<S-C-j>", "<cmd>wincmd j<cr>", {
    desc = "Go to lower window"
})
vim.api.nvim_set_keymap("t", "<S-C-k>", "<cmd>wincmd k<cr>", {
    desc = "Go to upper window"
})
vim.api.nvim_set_keymap("t", "<S-C-l>", "<cmd>wincmd l<cr>", {
    desc = "Go to right window"
})
vim.api.nvim_set_keymap("t", "<C-/>", "<cmd>close<cr>", {
    desc = "Hide Terminal"
})
vim.api.nvim_set_keymap("t", "<c-_>", "<cmd>close<cr>", {
    desc = "which_key_ignore"
})

--[==============[
   GITHUB COPILOT
--]==============]
-- Bind accept github copilot to <Tab>
vim.cmd("imap <silent><script><expr> <C-j> copilot#Accept('<CR>') ")
-- Bind accept word to ctrl + shift + l
vim.cmd("imap <silent><script><expr> <C-S-L> copilot#AcceptWord('<CR>') ")

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- function that lets us more easily define mappings specific for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, {
            buffer = bufnr,
            desc = desc
        })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {
        desc = 'Format current buffer with LSP'
    })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    svelte = {},
    tsserver = {},

    html = {
        filetypes = { 'html', 'twig', 'hbs' }
    },

    lua_ls = {
        Lua = {
            workspace = {
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            }
        }
    }
}


-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers)
}

mason_lspconfig.setup_handlers { function(server_name)
    require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes
    }
end }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    },
    sources = { {
        name = 'nvim_lsp'
    }, {
        name = 'luasnip'
    } }
}

-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
-- vim.command("au BufNewFile,BufRead *.xaml setlocal filetype=xml")

-- The line beneath this is called `modeline`. See `:help modeline`

-- vim.cmd("let g:loaded_netrw = 0")
vim.o.loaded_netrw = 0
vim.o.loaded_netrwPlugin = 0
vim.cmd("syntax on")
vim.o.termguicolors = true
vim.cmd( "autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) ")
