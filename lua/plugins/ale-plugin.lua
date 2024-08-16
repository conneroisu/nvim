---@module "ale-plugin"
---@author "Conner Ohnesorge"
---@license WTFPL

return {
	'dense-analysis/ale',
	dependencies = {
		'bufbuild/vim-buf',
	},
	config = function()
		-- Configuration goes here.
		local g = vim.g

		g.ale_ruby_rubocop_auto_correct_all = 1

		g.ale_linters = {
			ruby = { 'rubocop', 'ruby' },
			lua = { 'lua_language_server' },
			proto = { 'buf-lint' },
		}
	end
}
