--p  (otherwise wrong leader will be used)
vim.g.mapleader = '\\'; vim.g.maplocalleader = ' '; local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn .system {'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath}
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({{
    -- must  be installed first especiallly before lsp
    'folke/neodev.nvim',
    init = function()
        require('neodev').setup()
    end
}, 'tpope/vim-rhubarb', 'tpope/vim-sleuth', {
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
}, {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'onedark'
    end
}, {
    import = 'custom.plugins'
}})

require("config.options")

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
require'nvim-treesitter.install'.compilers = { "gcc", "clang", "clang++", "g++"}
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'c_sharp',
                        'astro', 'ninja', 'bash', "css", "rst", "toml"},

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
vim.api.nvim_set_keymap("x", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("x", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
vim.api.nvim_set_keymap("o", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result"
})
vim.api.nvim_set_keymap("o", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result"
})
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
    nmap('gr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", '[D]ocument [S]ymbols')
    nmap('<leader>ws', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
        '[W]orkspace [S]ymbols')
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

--  define the property 'filetypes' to the map in question, to override the default filetypes of a server.
local servers = {
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    svelte = {},
    tsserver = {},

    html = {
        filetypes = {'html', 'twig', 'hbs'}
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

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers)
}

mason_lspconfig.setup_handlers {function(server_name)
    require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes
    }
end}

vim.cmd("syntax on")
vim.cmd("set wrap!")
require("custom.keymaps.visual-keymaps")
require("custom.keymaps.insert-keymaps")
require("custom.keymaps.normal-keymaps")

vim.o.statusline = vim.o.statusline .. '%F'
