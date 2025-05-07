return {
  "kr40/nvim-macros",
  cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
  opts = {
    -- Location where the macros will be stored
    json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"),
    -- Use as default register for :MacroYank and :MacroSave and :MacroSelect Raw functions]]
    default_macro_register = "q",
    -- can be "none" | "jq" | "yq" used to pretty print the json file (jq or yq must be installed!)
    json_formatter = "none",
  }
}
