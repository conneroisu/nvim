-- Unicode Escape Converter for Neovim
-- Place this in your Neovim configuration (e.g., ~/.config/nvim/lua/unicode_escape.lua)
-- Then require it in your init.lua with: require('unicode_escape')

local M = {}

-- Function to convert a Unicode code point to UTF-8
local function codepoint_to_utf8(n)
  if n <= 0x7f then
    return string.char(n)
  elseif n <= 0x7ff then
    return string.char(
      bit.bor(0xc0, bit.rshift(n, 6)),
      bit.bor(0x80, bit.band(n, 0x3f))
    )
  elseif n <= 0xffff then
    return string.char(
      bit.bor(0xe0, bit.rshift(n, 12)),
      bit.bor(0x80, bit.band(bit.rshift(n, 6), 0x3f)),
      bit.bor(0x80, bit.band(n, 0x3f))
    )
  elseif n <= 0x10ffff then
    return string.char(
      bit.bor(0xf0, bit.rshift(n, 18)),
      bit.bor(0x80, bit.band(bit.rshift(n, 12), 0x3f)),
      bit.bor(0x80, bit.band(bit.rshift(n, 6), 0x3f)),
      bit.bor(0x80, bit.band(n, 0x3f))
    )
  end
  return nil
end

-- Main function to convert Unicode escapes in visual selection
function M.convert_unicode_escapes()
  -- Get the visual selection
  local start_line, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
  local end_line, end_col = unpack(vim.fn.getpos("'>"), 2, 3)

  -- Get the lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  if #lines == 0 then
    vim.notify("No text selected", vim.log.levels.WARN)
    return
  end

  local text
  if #lines == 1 then
    -- Single line selection
    text = string.sub(lines[1], start_col, end_col)
  else
    -- Multi-line selection
    local parts = {}
    parts[1] = string.sub(lines[1], start_col)
    for i = 2, #lines - 1 do
      parts[i] = lines[i]
    end
    parts[#lines] = string.sub(lines[#lines], 1, end_col)
    text = table.concat(parts, "\n")
  end

  -- Convert Unicode escapes
  local converted = text:gsub("\\u(%x%x%x%x)", function(hex)
    local codepoint = tonumber(hex, 16)
    if codepoint then
      local utf8 = codepoint_to_utf8(codepoint)
      if utf8 then
        return utf8
      end
    end
    return "\\u" .. hex -- Return original if conversion fails
  end)

  -- Also handle basic escape sequences
  converted = converted:gsub("\\n", "\n")
  converted = converted:gsub("\\t", "\t")
  converted = converted:gsub("\\r", "\r")
  converted = converted:gsub('\\"', '"')
  converted = converted:gsub("\\'", "'")
  converted = converted:gsub("\\\\", "\\")

  -- Replace the selection
  if #lines == 1 then
    -- Single line replacement
    local new_line = string.sub(lines[1], 1, start_col - 1) .. converted .. string.sub(lines[1], end_col + 1)
    vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false, { new_line })
  else
    -- Multi-line replacement
    local new_lines = vim.split(converted, "\n", { plain = true })

    -- Adjust first line
    new_lines[1] = string.sub(lines[1], 1, start_col - 1) .. new_lines[1]

    -- Adjust last line
    if #new_lines == #lines then
      new_lines[#new_lines] = new_lines[#new_lines] .. string.sub(lines[#lines], end_col + 1)
    else
      -- Handle case where number of lines changed
      local last_original = string.sub(lines[#lines], end_col + 1)
      if #new_lines > 0 then
        new_lines[#new_lines] = new_lines[#new_lines] .. last_original
      else
        new_lines = { lines[1]:sub(1, start_col - 1) .. last_original }
      end
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
  end

  vim.notify("Unicode escapes converted", vim.log.levels.INFO)
end

-- Alternative implementation using vim.fn.nr2char for Neovim without bit library
function M.convert_unicode_escapes_alt()
  -- Store the current register
  local save_reg = vim.fn.getreg('"')
  local save_regtype = vim.fn.getregtype('"')

  -- Yank the visual selection
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg('v')

  -- Convert Unicode escapes using vim's nr2char function
  local converted = text:gsub("\\u(%x%x%x%x)", function(hex)
    local codepoint = tonumber(hex, 16)
    if codepoint then
      return vim.fn.nr2char(codepoint)
    end
    return "\\u" .. hex
  end)

  -- Handle basic escape sequences
  converted = converted:gsub("\\n", "\n")
  converted = converted:gsub("\\t", "\t")
  converted = converted:gsub("\\r", "\r")
  converted = converted:gsub('\\"', '"')
  converted = converted:gsub("\\'", "'")
  converted = converted:gsub("\\\\", "\\")

  -- Put the converted text back
  vim.fn.setreg('v', converted)
  vim.cmd('normal! gv"vp')

  -- Restore the register
  vim.fn.setreg('"', save_reg, save_regtype)

  vim.notify("Unicode escapes converted", vim.log.levels.INFO)
end

-- Setup function to create the mapping
function M.setup()
  -- Main mapping using the alternative method (more reliable)
  vim.keymap.set('v', '<leader>u', function()
    M.convert_unicode_escapes_alt()
  end, { desc = 'Convert Unicode escape sequences to text' })

  -- Secondary mapping for testing the direct method
  vim.keymap.set('v', '<leader>U', function()
    M.convert_unicode_escapes()
  end, { desc = 'Convert Unicode escapes (alternative method)' })

  -- Create a command as well
  vim.api.nvim_create_user_command('UnicodeDecodeSelection', function()
    M.convert_unicode_escapes_alt()
  end, { range = true, desc = 'Decode Unicode escape sequences in selection' })
end

-- Auto-setup when module is required
M.setup()

return M
