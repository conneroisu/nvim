---@diagnostic disable: missing-fields
return {
  'neovim/nvim-lspconfig',
  event = { "BufReadPost", "BufNewFile" },
  on_attach = function(client, bufnr)
    require('completion').on_attach(client, bufnr)
    require('lsp_signature').on_attach()
  end,
  dependencies = {
    'j-hui/fidget.nvim',
    "folke/lazydev.nvim",
    -- "saghen/blink.cmp",
    "folke/neoconf.nvim",
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-nvim-lsp-signature-help",
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
    'nvimdev/lspsaga.nvim',
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
    },
    ---@class lspconfig.options
    servers = {
      basics_ls = {
        settings = {
          buffer = {
            enable = false,
          },
          path = {
            enable = false,
          },
          snippet = {
            enable = true,
            sources = {
              vim.fn.stdpath("config") .. "/snippets",
            },                       -- paths to package containing snippets, see examples below
            matchStrategy = 'fuzzy', -- or 'fuzzy'
          },
        }
      },
      golangci_lint_ls = {
      },
      lua_ls = {
        settings = {
          Lua = { workspace = { checkThirdParty = false, }, },
        },
      },
      ocamlls = {},
      ccls = {
        init_options = {
          cache = {
            directory = ".ccls-cache",
          },
        }
      },
      elmls = {},
      basedpyright = {},
      protols = {
        single_file_support = false,
        cmd = { "protols", "--include-paths=/home/connerohnesorge/Documents/002Orgs/pegwings/pegwings/proto/lib,/home/connerohnesorge/Documents/002Orgs/pegwings/pegwings/proto/src" },
      },
      -- clangd = {},
      ts_ls = {},
      rust_analyzer = {},
      texlab = {},
      vhdl_ls = {},
      tailwindcss = {},
      hdl_checker = {},
      jsonls = {},
      yamlls = {},
      dockerls = {},
      astro = {},
      svelte = {},
      htmx = {},
      hyprls = {},
      cssls = {},
      nixd = {
        formatting = {
          format_on_save = true,
        },
      },
      gopls = {
        settings = {
          gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
        init_options = {
          usePlaceholders = true,
        }
      },
      zls = {},
      templ = {},
      sqls = {},
    }
  },
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-y>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer" },
        { name = "path" },
        -- { name = "cmdline" },
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", vim_item.kind)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[BUF]",
            path = "[PATH]",
            cmdline = "[CMD]",
          })[entry.source.name]
          return vim_item
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert'
      }
    })
    require('lspsaga').setup({
      lightbulb = { enable = false },
    })
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    vim.filetype.add({ extension = { templ = "templ" } })
    local lspconfig = require("lspconfig")
    for server, config in pairs(opts.servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if vim.bo.filetype == "sql" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              if vim.fn.executable("sleek") == 1 then
                local pos = vim.api.nvim_win_get_cursor(0)
                vim.cmd("silent %!sleek -i 4")
                vim.api.nvim_win_set_cursor(0, pos)
              else
                vim.print("sleek not found")
              end
            end,
          })
        end

        if vim.bo.filetype == "python" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              if vim.fn.executable("black") == 1 then
                local pos = vim.api.nvim_win_get_cursor(0)
                vim.cmd("silent %!black -q -")
                vim.api.nvim_win_set_cursor(0, pos)
              end
            end,
          })
        end

        if client.supports_method("textDocument/formatting") and vim.bo.filetype ~= "sql" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({
                bufnr = args.buf,
                id = client.id,
              })
            end,
          })
        end
        -- Key Mappings
        if client.supports_method('textDocument/rename') then
          vim.keymap.set(
            'n',
            '<leader>rn',
            vim.lsp.buf.rename,
            { buffer = args.buf, desc = '[R]e[n]ame' }
          )
        end
        if client.supports_method('textDocument/formatting') then
          vim.keymap.set(
            'n',
            '<leader>cf',
            vim.lsp.buf.format,
            { buffer = args.buf, desc = '[C]ode [F]ormat' }
          )
        end
        if client.supports_method('textDocument/codeAction') then
          vim.keymap.set(
            'n',
            '<leader>ca',
            vim.lsp.buf.code_action,
            { buffer = args.buf, desc = '[C]ode [A]ction' }
          )
        end
        if client.supports_method('textDocument/documentSymbol') then
          vim.keymap.set(
            'n',
            '<leader>ls',
            vim.lsp.buf.document_symbol,
            { buffer = args.buf, desc = '[L]ocate [S]ymbols' }
          )
        end
        if client.supports_method('workspace/symbol') then
          vim.keymap.set(
            'n',
            '<leader>lws',
            vim.lsp.buf.workspace_symbol,
            { buffer = args.buf, desc = '[W]orkspace [S]ymbols' }
          )
        end
        if client.supports_method('textDocument/signatureHelp') then
          vim.keymap.set(
            'n',
            '<leader>sh',
            vim.lsp.buf.signature_help,
            { buffer = args.buf, desc = '[S]ignature [H]elp' }
          )
        end
        if client.supports_method('textDocument/hover') then
          vim.keymap.set(
            'n',
            'K',
            vim.lsp.buf.hover,
            { buffer = args.buf, desc = '[H]over' }
          )
        end
        if client.supports_method('textDocument/definition') then
          vim.keymap.set(
            'n',
            'gd',
            vim.lsp.buf.definition,
            { buffer = args.buf, desc = '[D]efinition' }
          )
        end
        if client.supports_method('textDocument/references') then
          vim.keymap.set(
            'n',
            '<leader>lr',
            vim.lsp.buf.references,
            { buffer = args.buf, desc = '[R]eferences' }
          )
        end
        if client.supports_method('textDocument/implementation') then
          vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { buffer = args.buf, desc = '[I]mplementation' })
        end
        if client.supports_method('textDocument/typeDefinition') then
          vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = args.buf, desc = '[T]ypeDefinition' })
        end
      end,
    })

    -- :Format command
    vim.api.nvim_create_user_command("Format", function()
      vim.lsp.buf.format()
    end, {})
  end,
}
