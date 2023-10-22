--[=======[
name: OmniSharp
author: OmniSharp
url: https://github.com/OmniSharp/omnisharp-vim
description: Vim plugin for OmniSharp, a cross platform .NET development
tags: ['dotnet', 'csharp', 'omnisharp', 'aspnet', 'aspnetcore', 'unity']
--]=======]

return {
	'OmniSharp/omnisharp-vim',
	dependencies = {
		{ 'prabirshrestha/asyncomplete.vim' },
		{ 'honza/vim-snippets' }
	},
	config = function()
		vim.cmd("let g:OmniSharp_server_stdio = 1")
		vim.cmd("let g:OmniSharp_server_use_mono = 1")
		vim.cmd("let g:asyncomplete_auto_popup = 1")
		vim.cmd("let g:asyncomplete_auto_completeopt = 0")
	end
}
