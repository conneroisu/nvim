---@module "anki-plugin"
---@author Conner Ohnesorge
---@license WTFPL

return {
    "rareitems/anki.nvim",
    opts = {
        {
            -- this function will add support for associating '.anki' extension with both 'anki' and 'tex' filetype.
            tex_support = true,
            xclip_path = "xclip",
            models = {
                -- Here you specify which notetype should be associated with which deck
                NoteType = "PathToDeck",
                ["Basic"] = "EE332",
                ["Super Basic"] = "Deck::ChildDeck",
            },
        }
    },
    config = function()
        require("anki").setup {
        }
    end,
}
