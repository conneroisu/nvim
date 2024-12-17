---@module "lspconfig-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
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
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local opts = {
      servers = {
        lua_ls = {},
        basedpyright = {},
        ts_ls = {},
        texlab = {},
        taplo = {},
        hdl_checker = {},
        tailwindcss = {
          filetypes = { "css", "scss", "javascript", "typescript", "astro", "svelte", "html", "vue", "templ" }
        },
        rust_analyzer = {},
        jsonls = {},
        yamlls = {},
        clangd = {},
        ghdl_ls = {},
        dockerls = {},
        astro = {},
        svelte = {},
        html = {},
        htmx = {
          filetypes = { "css", "scss", "javascript", "typescript", "astro", "svelte", "html", "vue", "templ" },
        },
        hyprls = {},
        cssls = {},
        css_variables = {},
        nixd = {},
        nil_ls = {},
        ocamlls = {},
        remark_ls = {},
        zls = {},
        templ = {},
        marksman = {},
        jdtls = {},
        cmake = {},
        vhdl_ls = {},
        sqls = {},
        verible = {},
        veridian = {},
      }
    }
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

        -- if supports renaming
        if client.supports_method('textDocument/rename') then
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf, desc = '[R]e[n]ame' })
        end

        -- if supports formatting
        if client.supports_method('textDocument/formatting') then
          vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { buffer = args.buf, desc = '[C]ode [F]ormat' })
        end

        -- if supports code actions
        if client.supports_method('textDocument/codeAction') then
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = '[C]ode [A]ction' })
        end

        -- if supports document symbols
        if client.supports_method('textDocument/documentSymbol') then
          vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol,
            { buffer = args.buf, desc = '[L]ocate [S]ymbols' })
        end

        -- if supports workspace symbols
        if client.supports_method('workspace/symbol') then
          vim.keymap.set('n', '<leader>lws', vim.lsp.buf.workspace_symbol,
            { buffer = args.buf, desc = '[W]orkspace [S]ymbols' })
        end

        -- if supports signature help
        if client.supports_method('textDocument/signatureHelp') then
          vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help,
            { buffer = args.buf, desc = '[S]ignature [H]elp' })
        end

        -- if supports hover
        if client.supports_method('textDocument/hover') then
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf, desc = '[H]over' })
        end

        -- if supports definition
        if client.supports_method('textDocument/definition') then
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = '[D]efinition' })
        end

        -- if supports references
        if client.supports_method('textDocument/references') then
          vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { buffer = args.buf, desc = '[R]eferences' })
        end

        -- if supports implementations
        if client.supports_method('textDocument/implementation') then
          vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, { buffer = args.buf, desc = '[I]mplementation' })
        end
      end,
    })
  end,
}
