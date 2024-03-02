return {
	'OmniSharp/omnisharp-vim',
	dependencies = {
		{ 'prabirshrestha/asyncomplete.vim' },
		{ 'honza/vim-snippets' }
	},
	config = function()
		vim.cmd("let g:OmniSharp_server_stdio = 1")
		vim.cmd("let g:OmniSharp_server_use_mono = 0")
		vim.cmd("let g:asyncomplete_auto_popup = 1")
		vim.cmd("let g:asyncomplete_auto_completeopt = 0")
	end
}
