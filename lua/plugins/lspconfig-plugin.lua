return {
  -- lspconfig
  'neovim/nvim-lspconfig',
  event = { "BufReadPost", "BufNewFile" },
  on_attach = function(client, bufnr)
    require('completion').on_attach(client, bufnr)
    require('lsp_signature').on_attach()
  end,
  dependencies = {
    'j-hui/fidget.nvim',
    "folke/lazydev.nvim",
    "saghen/blink.cmp",
    "folke/neoconf.nvim",
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
      lua_ls = {
        settings = {
          Lua = { workspace = { checkThirdParty = false, }, },
        },
      },
      ccls = {
        init_options = {
          cache = {
            directory = ".ccls-cache",
          },
        }
      },
      basedpyright = {},
      protols = {},
      ts_ls = {},
      -- golangci_lint_ls = {},
      texlab = {},
      tailwindcss = {
        filetypes = { "css", "scss", "javascript", "typescript", "astro", "svelte", "html", "vue", "templ" }
      },
      jsonls = {},
      yamlls = {},
      -- ghdl_ls = {},
      -- hdl_checker = {},
      -- vhdl_ls = {},
      dockerls = {},
      astro = {},
      svelte = {},
      -- nushell = {},
      -- html = {},
      htmx = {
        filetypes = { "css", "scss", "javascript", "typescript", "astro", "svelte", "html", "vue", "templ" },
      },
      hyprls = {},
      cssls = {},
      -- nil_ls = {},
      nixd = {
        formatting = {
          format_on_save = true,
        },
      },
      gopls = {},
      -- ocamlls = {},
      zls = {},
      templ = {},
      marksman = {},
      -- jdtls = {},
      -- cmake = {},
      sqls = {},
      -- verible = {},
      -- veridian = {},
    }
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    for server, config in pairs(opts.servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if vim.bo.filetype == "nix" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            callback = function()
              if vim.fn.executable("alejandra") == 1 then
                local pos = vim.api.nvim_win_get_cursor(0)
                vim.cmd("silent %!alejandra --quiet -")
                vim.api.nvim_win_set_cursor(0, pos)
              end
            end,
          })
        end

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
        if client.supports_method('textDocument/rename') then
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf, desc = '[R]e[n]ame' })
        end
        if client.supports_method('textDocument/formatting') then
          vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { buffer = args.buf, desc = '[C]ode [F]ormat' })
        end
        if client.supports_method('textDocument/codeAction') then
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = '[C]ode [A]ction' })
        end
        if client.supports_method('textDocument/documentSymbol') then
          vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol,
            { buffer = args.buf, desc = '[L]ocate [S]ymbols' })
        end
        if client.supports_method('workspace/symbol') then
          vim.keymap.set('n', '<leader>lws', vim.lsp.buf.workspace_symbol,
            { buffer = args.buf, desc = '[W]orkspace [S]ymbols' })
        end
        if client.supports_method('textDocument/signatureHelp') then
          vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help,
            { buffer = args.buf, desc = '[S]ignature [H]elp' })
        end
        if client.supports_method('textDocument/hover') then
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf, desc = '[H]over' })
        end
        if client.supports_method('textDocument/definition') then
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = '[D]efinition' })
        end
        if client.supports_method('textDocument/references') then
          vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { buffer = args.buf, desc = '[R]eferences' })
        end
        if client.supports_method('textDocument/implementation') then
          vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { buffer = args.buf, desc = '[I]mplementation' })
        end
        if client.supports_method('textDocument/typeDefinition') then
          vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = args.buf, desc = '[T]ypeDefinition' })
        end
      end,
    })

    -- Format :Format command
    vim.api.nvim_create_user_command("Format", function()
      vim.lsp.buf.format()
    end, {})
  end,
}
