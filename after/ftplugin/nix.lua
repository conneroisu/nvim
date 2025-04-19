-- Create an autocommand group for remembering folds in Nix files
vim.api.nvim_create_augroup('steeltrap_nix', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = '*.nix',
  group = 'steeltrap_nix',
  command = 'mkview'
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  pattern = '*.nix',
  group = 'steeltrap_nix',
  command = 'silent! loadview'
})

vim.api.nvim_create_autocmd("BufWriteCmd", {
  ---@param args vim.api.keyset.create_autocmd.callback_args
  callback = function(args)
    if vim.fn.executable("alejandra") == 1 then
      local cursor_position = vim.api.nvim_win_get_cursor(0)
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local content = table.concat(lines, "\n")
      local check_result = vim.fn.system("alejandra --check --quiet - 2>&1", content)
      local check_code = vim.v.shell_error

      if check_code == 1 then
        local error_msg
        if check_result:find("Failed!") then
          error_msg = check_result:match("Failed!.*")
        else
          error_msg = check_result
        end
        vim.print("Error in Nix file (" .. args.file .. "): " .. error_msg)
        return false
      elseif check_code == 2 then
        -- Formatting is needed, apply it
        local formatted = vim.fn.system("alejandra --quiet - ", content)
        -- Apply the formatted content
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(formatted, "\n"))
        vim.api.nvim_win_set_cursor(0, cursor_position)
        vim.print("Formatted Nix file (" .. args.file .. ")")
      end
      -- If check_code == 0, file is already formatted, do nothing
    end
  end,
})
