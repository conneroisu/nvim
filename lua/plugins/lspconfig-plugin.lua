---@module "lspconfig-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
  -- lspconfig
  'neovim/nvim-lspconfig',
  event = { "BufReadPost", "BufNewFile" },
  on_attach = function(client, bufnr)
    require('completion').on_attach(client, bufnr)
    require('lsp_signature').on_attach()
  end,
  dependencies = {
    {
      'j-hui/fidget.nvim',
    },
    "folke/lazydev.nvim",
    "saghen/blink.cmp",
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
    },
    ---@type lspconfig.options
    servers = {
      lua_ls = {
        settings = {
          Lua = { workspace = { checkThirdParty = false, }, },
        },
      },
      basedpyright = {},
      ts_ls = {},
      texlab = {},
      tailwindcss = {
        filetypes = { "css", "scss", "javascript", "typescript", "astro", "svelte", "html", "vue", "templ" }
      },
      rust_analyzer = {},
      jsonls = {},
      yamlls = {},
      -- ghdl_ls = {},
      -- hdl_checker = {},
      -- vhdl_ls = {},
      dockerls = {},
      astro = {},
      svelte = {},
      html = {},
      htmx = {
        filetypes = { "css", "scss", "javascript", "typescript", "astro", "svelte", "html", "vue", "templ" },
      },
      hyprls = {},
      cssls = {},
      nixd = {},
      -- ocamlls = {},
      zls = {},
      templ = {},
      marksman = {},
      -- jdtls = {},
      -- cmake = {},
      sqls = {},
      verible = {},
      veridian = {},
    }
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    for server, config in pairs(opts.servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        if vim.bo.filetype == "go" then
          lspconfig.gopls.setup({ capabilities = capabilities, })
        end
      end,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        if client.supports_method("textDocument/formatting") then
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
      end,
    })
  end,
}
