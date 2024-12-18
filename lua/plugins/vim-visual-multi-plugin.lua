return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "BufEnter",
  config = function()
    -- Extract block supports only normal mode
    vim.cmd("let g:VM_maps['Select Cursor Down'] = '<M-S-Down>'")
    vim.cmd("let g:VM_maps['Select Cursor Up'] = '<M-S-Up>'")
  end
}
