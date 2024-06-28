-- if it is linux then url is /run/media/conner/source/001Repos/seltabl/tools/tools
-- if it is mac then url is /Users/conneroisu/source/001Repos/seltabl/tools/tools
---@diagnostic disable-next-line: missing-fields
local client = vim.lsp.start {
	name = "seltabls",
	cmd = { "seltabls", "lsp" },
	on_attach = function(_, bufnr)
		local opts = { buffer = bufnr, remap = true }
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
			vim.lsp.buf.format()
		end, {
			desc = "Format current buffer with LSP",
		})
		vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {
			buffer = bufnr,
			remap = true,
			desc = "[R]e[n]ame"
		})
		vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.code_action() end, {
			buffer = bufnr,
			remap = true,
			desc = "[C]ode [A]ction"
		})
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {
			buffer = bufnr,
			remap = true,
			desc = "[G]oto [D]efinition"
		})
		vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, {
			buffer = bufnr,
			remap = true,
			desc = "[G]oto [I]mplementation"
		})
		vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end, {
			buffer = bufnr,
			remap = true,
			desc = "Type [D]efinition"
		})
		vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, {
			buffer = bufnr,
			remap = true,
			desc = "Signature Documentation"
		})
		vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, {
			buffer = bufnr,
			remap = true,
			desc = "[G]oto [D]eclaration"
		})
		vim.keymap.set("n", "<leaderawf", function() vim.lsp.buf.add_workspace_folder() end, {
			buffer = bufnr,
			remap = true,
			desc = "[W]orkspace [A]dd Folder"
		})
		vim.keymap.set("n", "<leader>rwf", function() vim.lsp.buf.remove_workspace_folder() end, {
			buffer = bufnr,
			remap = true,
			desc = "[W]orkspace [R]emove Folder"
		})
		vim.keymap.set("n", "<leader>lwr", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, {
			buffer = bufnr,
			remap = true,
			desc = "[W]orkspace [L]ist Folders"
		})
		vim.keymap.set("n", "<leader>dp", function() vim.lsp.buf.peek_definition() end, {
			buffer = bufnr,
			remap = true,
			desc = "[P]eek [D]efinition"
		})
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		require('mason').setup()
	end,
}

if not client then
	vim.notify("Failed to start seltabl-lsp")
	print("Failed to start seltabl-lsp")
	return
end


vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.go",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.lsp.buf_attach_client(bufnr, client)
	end
})
