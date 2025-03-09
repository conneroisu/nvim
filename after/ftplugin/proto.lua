vim.bo.commentstring = "// %s"

vim.print("proto.lua loaded")
-- proto_fold.lua
-- A Neovim script for folding sections in proto files based on headings

-- Define the pattern for section headers
-- Looking for lines like "// # SECTION_NAME"
local function is_heading(line)
  return line:match("^%s*//+%s*#%s+%w+")
end

-- Custom fold expression function
function ProtoFoldExpr(lnum)
  local line = vim.fn.getline(lnum)

  -- If this is a header line, start a fold
  if is_heading(line) then
    return ">1"
  end

  -- Check if the next line is a header (which would end this fold)
  local next_line = vim.fn.getline(lnum + 1)
  if next_line ~= "" and is_heading(next_line) then
    return "<1"
  end

  -- Otherwise, continue with the current fold level
  return "="
end

-- Set up the folding immediately when the script is executed
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.ProtoFoldExpr(v:lnum)"

-- Optional fold settings - uncomment if desired
-- vim.wo.foldenable = true
-- vim.wo.foldlevel = 0      -- Start with all folds closed
-- vim.wo.foldnestmax = 1    -- Maximum fold nesting level

-- Make the fold function available globally
_G.ProtoFoldExpr = ProtoFoldExpr
