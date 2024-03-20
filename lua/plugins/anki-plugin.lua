return {
    "rareitems/anki.nvim",
    -- lazy -- don't lazy it, it tries to be as lazy possible and it needs to add a filetype association
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
