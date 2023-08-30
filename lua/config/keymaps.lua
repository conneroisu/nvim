
-- TELESCOPE ==========================================================================================================
-- bind leader + g + p to open telescope projects in normal mode
vim.api.nvim_set_keymap("n", "<leader>gp", "Oil S:<cr>", { desc = "Open  projects " })
-- bind Control + o to open recent files in normal mode
vim.api.nvim_set_keymap("n", "<C-o>", ":Telescope oldfiles<CR>", { noremap = true, silent = true })


vim.keymap.set("n", "<leader>u", "<Cmd>UrlView<CR>", { desc = "View buffer URLs" })
vim.keymap.set("n", "<leader>U", "<Cmd>UrlView packer<CR>", { desc = "View Packer plugin URLs" })

-- tabs
vim.api.nvim_set_keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.api.nvim_set_keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- buffers
vim.api.nvim_set_keymap("n", "<C-Left>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.api.nvim_set_keymap("n", "<C-Right>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.api.nvim_set_keymap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.api.nvim_set_keymap("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- Bind redo to Ctrl + Y
vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>redo<cr>", { desc = "Redo" })
-- Bind the previous file to alt+left like in a browser.
vim.api.nvim_set_keymap("n", "<A-Left>", ":edit #<cr>", { silent = true })
-- bind leader + x + L to open location list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List (Trouble)" })
-- bind leader + x + Q to open quickfix list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List (Trouble)" })
-- bind leader + u + u to open undotree in normal mode
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
-- bind <leader> + x + x to open document diagnostics in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>xx",
	"<cmd>TroubleToggle document_diagnostics<cr>",
	{ desc = "Document Diagnostics (Trouble)" }
)
-- bind <leader> + x + w to open workspace diagnostics
vim.api.nvim_set_keymap(
	"n",
	"<leader>xX",
	"<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ desc = "Workspace Diagnostics (Trouble)" }
)
-- bind leader + g + h to open the Octo github issue list in normal mode
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>:Octo issue list<CR>", { desc = "Open the Octo issue list" })
-- bind leader + w to open the URL view
vim.keymap.set("n", "<leader>w", "<Cmd>UrlView<CR>", { desc = "View buffer URLs" })
-- lazy
vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>:Lazy<cr>", { desc = "Lazy" })



--[=======[
   Neotest
--]=======]
vim.api.nvim_set_keymap(
	"n",
	"<leader>td",
	":lua require('neotest').run.run({strategy = 'dap'})<CR>",
	{ noremap = true, silent = true }
)

vim.cmd(":command Wq wq")
vim.cmd(":command VS vs")
vim.cmd(":command Vs vs")
vim.cmd(":command W w")
vim.cmd(":command Q q")

-- Open file in Obsidian vault
--macos
vim.cmd(
	[[command! -nargs=0 IO execute "silent !open 'obsidian://open?vault=SecondBrain&file=" . expand('%:t:r') . "'"]]
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>io",
	":IO<CR>",
	{ noremap = true, silent = true, desc = "Open in Obsidian (MacOS)" }
)

vim.api.nvim_set_keymap("n", "<leader>hu", "<cmd>Git<cr>", { desc = "Git" })

-- bind the leader + u + n to dismiss all notifications in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>un",
	"<cmd>lua require('notify').dismiss({silent = true, pending = true})<cr>",
	{ desc = "Dismiss all Notifications" }
)
-- set leader key + c + o to toggle comments in normal and visual mode
vim.api.nvim_set_keymap("n", "<leader>co", "<cmd>CommentToggle<cr>", { desc = "Comment Toggle" })
-- bind leader + c + o to toggle comments in visual mode
vim.api.nvim_set_keymap("v", "<leader>co", ":'<,'>CommentToggle<cr>", { desc = "Visual Comment Toggle" })
-- map leader + x + x to toggle the document diagnostics from trouble in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>xx",
	"<cmd>TroubleToggle document_diagnostics<cr>",
	{ desc = "Document Diagnostics (Trouble)" }
)
-- map leader + x + X to toggle the workpace diagnostics from trouble in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>xX",
	"<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ desc = "Workspace Diagnostics (Trouble)" }
)
-- bind leader + x + L to toggle the loclist from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List (Trouble)" })
-- bind leader + x + Q to toggle the quickfix list from trouble in normal mode
vim.api.nvim_set_keymap("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List (Trouble)" })
-- bind leader + a + g to generate a github commit message from the git diff in normal mode
vim.api.nvim_set_keymap(
	"n",
	"<leader>ag",
	":NeoAIShortcut gitcommit<CR>",
	{ desc = "Generate a git diff commit message." }
)
-- bind leader + u + u to toggle the undo tree view in normal mode
vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "Open Undo Tree" })
-- bind leader + g + i to the coc command to go to implementation in normal mode
vim.api.nvim_set_keymap("n", "<leader>gi", "<cmd><plug>(coc-implementation)<CR>", { desc = "Go to implementation" })
-- bind leader + g + t to the coc command to go to type definition in normal mode
vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd><plug>(coc-type-definition)<CR>", { desc = "Go to type definition" })
-- bind leader + g + d to the coc command to go to definition in normal mode
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd><plug>(coc-definition)<CR>", { desc = "Go to definition" })
-- bind leader + g + r to the coc command to go to references in normal mode
vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd><plug>(coc-references)<CR>", { desc = "Go to references" })
-- Bind leader  + c + l to open coc diagnostics
vim.api.nvim_set_keymap("n", "<leader>cl", ":CocDiagnostics<CR>", { desc = "Open diagnostics" })
-- bind leader + c + h to coc command to open hover doc in visual mode
vim.api.nvim_set_keymap("v", "<leader>ch", ":call CocAction('doHover')<CR>", { desc = "Open hover doc" })
-- bind leader + c + h to coc command to do a code action at the cursor in normal mode
vim.api.nvim_set_keymap("n", "<leader>cf", "<plug>(coc-codeaction-cursor)", { desc = "Code Action Cursor" })
-- bind leader + c + a to coc command to do a code fix at the cursor in normal mode
vim.api.nvim_set_keymap("n", "<leader>ca", "<plug>(coc-fix-current)", { desc = "Fix current" })
-- bind leader + e to open the init.lua file in normal mode
vim.api.nvim_set_keymap("n", "<leader>e", ":e $MYVIMRC<CR>", { noremap = true, silent = true })
-- bind leader + m to open oil file explorer in normal mode
--vim.api.nvim_set_keymap("n", "<leader>m", ":Oil<CR>", { noremap = true, silent = true })

-- bind shift + h to move to the start of the line in normal mode
vim.api.nvim_set_keymap("n", "<C-h>", "^", { noremap = true, silent = true })
-- bind shift + l to move to the end of the line in normal mode
vim.api.nvim_set_keymap("n", "<C-l>", "$", { noremap = true, silent = true })
vim.cmd("map <C-l> $")
vim.cmd("map <C-h> ^")

-- Move Lines
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.api.nvim_set_keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.api.nvim_set_keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.api.nvim_set_keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

vim.api.nvim_set_keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.api.nvim_set_keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.api.nvim_set_keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.api.nvim_set_keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.api.nvim_set_keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.api.nvim_set_keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { desc = "Remove Indent" })
vim.api.nvim_set_keymap("v", ">", ">gv", { desc = "Add Indent" })

-- new file
vim.api.nvim_set_keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- floating terminal
local lazyterm = function()
	Util.float_term(nil, { cwd = Util.get_root() })
end

-- Terminal vim.api.nvim_set_keymappings
vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.api.nvim_set_keymap("t", "<S-C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
vim.api.nvim_set_keymap("t", "<S-C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
vim.api.nvim_set_keymap("t", "<S-C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
vim.api.nvim_set_keymap("t", "<S-C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
vim.api.nvim_set_keymap("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.api.nvim_set_keymap("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

--[==============[
   GITHUB COPILOT
--]==============]
-- Bind accept github copilot to <Tab>
vim.cmd("imap <silent><script><expr> <C-j> copilot#Accept('<CR>') ")
-- Bind accept word to ctrl + shift + l
vim.cmd("imap <silent><script><expr> <C-S-L> copilot#AcceptWord('<CR>') ")


    local keyset = vim.keymap.set
    -- Autocomplete
    function _G.check_back_space()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
    end

    -- Use Tab for trigger completion with characters ahead and navigate
    -- NOTE: There's always a completion item selected by default, you may want to enable
    -- no select by setting `"suggest.noselect": true` in your configuration file
    -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
    -- other plugins before putting this into your config
    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
    keyset(
      "i",
      "<TAB>",
      'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
      opts
    )
    keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

    -- Make <CR> to accept selected completion item or notify coc.nvim to format
    -- <C-g>u breaks current undo, please make your own choice
    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

    -- Use <c-s> to trigger snippets
    keyset("i", "<c-s>", "<Plug>(coc-snippets-expand-jump)")
    -- Use <c-space> to trigger completion
    keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

    -- Use `[g` and `]g` to navigate diagnostics
    -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
    keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

    -- Symbol renaming to F2
    keyset("n", "<F2>", ":IncRename ")

    -- GoTo code navigation
    keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
    keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
    keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
    keyset("n", "gr", "<Plug>(coc-references)", { silent = true })
    keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
    keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

    -- Use K to show documentation in preview window
    function _G.show_docs()
      local cw = vim.fn.expand("<cword>")
      if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command("h " .. cw)
      elseif vim.api.nvim_eval("coc#rpc#ready()") then
        vim.fn.CocActionAsync("doHover")
      else
        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
      end
    end

    keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })


    -- Apply rodeAction to the selected region
    -- Example: `<leader>aap` for current paragraph
    keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
    keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

    -- Remap keys for apply code actions at the cursor position.
    keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
    -- Remap keys for apply source code actions for current file.
    keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
    -- Apply the most preferred quickfix action on the current line.
    keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

    -- Remap keys for apply refactor code actions.
    keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
    keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
    keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

    -- Run the Code Lens actions on the current line
    keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
    keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
    keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
    keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
    keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
    keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
    keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
    keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
    keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

    -- Remap <C-f> and <C-b> to scroll float windows/popups
    ---@diagnostic disable-next-line: redefined-local
    keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
    keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
    keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
    keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
    keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

    -- Use CTRL-S for selections ranges
    -- Requires 'textDocument/selectionRange' support of language server
    keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
    keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

    -- Show all diagnostics
    keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
    -- Manage extensions
    keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
    -- Show commands
    keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
    -- Find symbol of current document
    keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
    -- Search workspace symbols
    keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
    -- Do default action for next item
    keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
    -- Do default action for previous item
    keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
    -- Resume latest coc list
    keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
    vim.cmd("CocCommand document.toggleCodeLens")

-- bind leader + g + h to open the Octo github issue list in normal mode
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>:Octo issue list<CR>", { desc = "Open the Octo issue list" })
