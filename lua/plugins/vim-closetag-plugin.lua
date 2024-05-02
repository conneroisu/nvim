---@module "vim-closetag-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    'alvan/vim-closetag',
    config = function ()
-- "
-- let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
--
-- " filenames like *.xml, *.xhtml, ...
-- " This will make the list of non-closing tags self-closing in the specified files.
-- "
-- let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
        --
        vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.xml,*.tsx,*.templ'
    end
}
