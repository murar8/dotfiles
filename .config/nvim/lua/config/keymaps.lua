LazyVim.safe_keymap_set("n", "<leader><BS>", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
vim.keymap.del("t", "<esc><esc>")

if not vim.g.vscode then
	return
end

local mappings = {
	{
		key = "j", -- Down
		modes = { "n", "x" },
	},
	{
		key = "<Down>", -- Down
		modes = { "n", "x" },
	},
	{
		key = "k", -- Up
		modes = { "n", "x" },
	},
	{
		key = "<Up>", -- Up
		modes = { "n", "x" },
	},
	{
		key = "<C-h>", -- Go to Left Window
		modes = { "n", "t" },
		action = "workbench.action.navigateLeft",
	},
	{
		key = "<C-j>", -- Go to Lower Window
		modes = { "n", "t" },
		action = "workbench.action.navigateDown",
	},
	{
		key = "<C-k>", -- Go to Upper Window
		modes = { "n", "t" },
		action = "workbench.action.navigateUp",
	},
	{
		key = "<C-l>", -- Go to Right Window
		modes = { "n", "t" },
		action = "workbench.action.navigateRight",
	},
	{
		key = "<C-Up>", -- Increase Window Height
		modes = { "n" },
		action = "workbench.action.decreaseViewHeight",
	},
	{
		key = "<C-Down>", -- Decrease Window Height
		modes = { "n" },
		action = "workbench.action.increaseViewHeight",
	},
	{
		key = "<C-Left>", -- Decrease Window Width
		modes = { "n" },
		action = "workbench.action.increaseViewWidth",
	},
	{
		key = "<C-Right>", -- Increase Window Width
		modes = { "n" },
		action = "workbench.action.decreaseViewWidth",
	},
	{
		key = "<A-j>", -- Move Down
		modes = { "n", "i", "v" },
		action = "editor.action.moveLinesDownAction",
	},
	{
		key = "<A-k>", -- Move Up
		modes = { "n", "i", "v" },
		action = "editor.action.moveLinesUpAction",
	},
	{
		key = "<S-h>", -- Prev Buffer
		modes = { "n" },
		action = "workbench.action.previousEditor",
	},
	{
		key = "<S-l>", -- Next Buffer
		modes = { "n" },
		action = "workbench.action.nextEditor",
	},
	{
		key = "[b", -- Prev Buffer
		modes = { "n" },
		action = "workbench.action.previousEditor",
	},
	{
		key = "]b", -- Next Buffer
		modes = { "n" },
		action = "workbench.action.nextEditor",
	},
	{
		key = "<leader>bb", -- Switch to Other Buffer
		modes = { "n" },
	},
	{
		key = "<leader>`", -- Switch to Other Buffer
		modes = { "n" },
	},
	{
		key = "<leader>bd", -- Delete Buffer
		modes = { "n" },
		action = "workbench.action.closeActiveEditor",
	},
	{
		key = "<leader><bs>", -- Delete Buffer
		modes = { "n" },
		action = "workbench.action.closeActiveEditor",
	},
	{
		key = "<leader>bD", -- Delete Buffer and Window
		modes = { "n" },
		action = "workbench.action.closeEditorsAndGroup",
	},
	{
		key = "<esc>", -- Escape and Clear hlsearch
		modes = { "i", "n" },
	},
	{
		key = "<leader>ur", -- Redraw / Clear hlsearch / Diff Update
		modes = { "n" },
	},
	{
		key = "n", -- Next Search Result
		modes = { "n", "x", "o" },
	},
	{
		key = "N", -- Prev Search Result
		modes = { "n", "x", "o" },
	},
	{
		key = "<C-s>", -- Save File
		modes = { "i", "x", "n", "s" },
	},
	{
		key = "<leader>K", -- keywordprg
		modes = { "n" },
	},
	{
		key = "gco", -- Add Comment Below
		modes = { "n" },
	},
	{
		key = "gcO", -- Add Comment Above
		modes = { "n" },
	},
	{
		key = "<leader>l", -- Lazy
		modes = { "n" },
	},
	{
		key = "<leader>fn", -- New File
		modes = { "n" },
		action = "workbench.action.files.newUntitledFile",
	},
	{
		key = "<leader>xl", -- Location List
		modes = { "n" },
		action = "workbench.action.showAllSymbols",
	},
	{
		key = "<leader>xq", -- Quickfix List
		modes = { "n" },
	},
	{
		key = "[q", -- Previous Quickfix
		modes = { "n" },
	},
	{
		key = "]q", -- Next Quickfix
		modes = { "n" },
	},
	{
		key = "<leader>cf", -- Format
		modes = { "n", "v" },
		action = "editor.action.formatDocument",
	},
	{
		key = "<leader>cd", -- Line Diagnostics
		modes = { "n" },
		action = "editor.action.showHover",
	},
	{
		key = "]d", -- Next Diagnostic
		modes = { "n" },
		action = "editor.action.marker.next",
	},
	{
		key = "[d", -- Prev Diagnostic
		modes = { "n" },
		action = "editor.action.marker.prev",
	},
	{
		key = "]e", -- Next Error
		modes = { "n" },
	},
	{
		key = "[e", -- Prev Error
		modes = { "n" },
	},
	{
		key = "]w", -- Next Warning
		modes = { "n" },
	},
	{
		key = "[w", -- Prev Warning
		modes = { "n" },
	},
	{
		key = "<leader>uf", -- Toggle Auto Format (Global)
		modes = { "n" },
	},
	{
		key = "<leader>uF", -- Toggle Auto Format (Buffer)
		modes = { "n" },
	},
	{
		key = "<leader>us", -- Toggle Spelling
		modes = { "n" },
	},
	{
		key = "<leader>uw", -- Toggle Wrap
		modes = { "n" },
		action = "editor.action.toggleWordWrap",
	},
	{
		key = "<leader>uL", -- Toggle Relative Number
		modes = { "n" },
	},
	{
		key = "<leader>ud", -- Toggle Diagnostics
		modes = { "n" },
		action = "workbench.actions.view.toggleProblems",
	},
	{
		key = "<leader>ul", -- Toggle Line Numbers
		modes = { "n" },
		action = "editor.action.toggleLineNumbers",
	},
	{
		key = "<leader>uc", -- Toggle conceallevel
		modes = { "n" },
	},
	{
		key = "<leader>uT", -- Toggle Treesitter Highlight
		modes = { "n" },
	},
	{
		key = "<leader>ub", -- Toggle Background
		modes = { "n" },
	},
	{
		key = "<leader>uh", -- Toggle Inlay Hints
		modes = { "n" },
	},
	{
		key = "<leader>gg", -- Lazygit (Root Dir)
		modes = { "n" },
		action = "workbench.view.scm",
	},
	{
		key = "<leader>gG", -- Lazygit (cwd)
		modes = { "n" },
		action = "workbench.view.scm",
	},
	{
		key = "<leader>gb", -- Git Blame Line
		modes = { "n" },
		action = "gitlens.toggleFileBlame",
	},
	{
		key = "<leader>gB", -- Git Browse
		modes = { "n" },
		action = "gitlens.openFileOnRemote",
	},
	{
		key = "<leader>gf", -- Lazygit Current File History
		modes = { "n" },
		action = "gitlens.showQuickFileHistory",
	},
	{
		key = "<leader>gl", -- Lazygit Log
		modes = { "n" },
		action = "gitlens.showQuickRepoHistory",
	},
	{
		key = "<leader>gL", -- Lazygit Log (cwd)
		modes = { "n" },
		action = "gitlens.showQuickRepoHistory",
	},
	{
		key = "<leader>qq", -- Quit All
		modes = { "n" },
		action = "workbench.action.quit",
	},
	{
		key = "<leader>ui", -- Inspect Pos
		modes = { "n" },
		action = "editor.action.showHover",
	},
	{
		key = "<leader>uI", -- Inspect Tree
		modes = { "n" },
	},
	{
		key = "<leader>L", -- LazyVim Changelog
		modes = { "n" },
	},
	{
		key = "<leader>ft", -- Terminal (Root Dir)
		modes = { "n" },
		action = "workbench.action.terminal.toggleTerminal",
	},
	{
		key = "<leader>fT", -- Terminal (cwd)
		modes = { "n" },
		action = "workbench.action.terminal.toggleTerminal",
	},
	{
		key = "<c-/>", -- Terminal (Root Dir)
		modes = { "n" },
		action = "workbench.action.terminal.toggleTerminal",
	},
	{
		key = "<c-_>", -- which_key_ignore
		modes = { "n", "t" },
	},
	{
		key = "<esc><esc>", -- Enter Normal mode
		modes = { "t" },
	},
	{
		key = "<c-/>", -- Hide Terminal
		modes = { "t" },
	},
	{
		key = "<leader>w", -- Windows
		modes = { "n" },
		action = "workbench.action.quickSwitchWindow",
	},
	{
		key = "<leader>-", -- Split Window Below
		modes = { "n" },
		action = "workbench.action.splitEditorDown",
	},
	{
		key = "<leader>|", -- Split Window Right
		modes = { "n" },
		action = "workbench.action.splitEditorRight",
	},
	{
		key = "<leader>wd", -- Delete Window
		modes = { "n" },
		action = "workbench.action.closeEditorsInGroup",
	},
	{
		key = "<leader>wm", -- Toggle Maximize
		modes = { "n" },
		action = "workbench.action.toggleEditorWidths",
	},
	{
		key = "<leader><tab>l", -- Last Tab
		modes = { "n" },
	},
	{
		key = "<leader><tab>o", -- Close Other Tabs
		modes = { "n" },
	},
	{
		key = "<leader><tab>f", -- First Tab
		modes = { "n" },
	},
	{
		key = "<leader><tab><tab>", -- New Tab
		modes = { "n" },
	},
	{
		key = "<leader><tab>]", -- Next Tab
		modes = { "n" },
	},
	{
		key = "<leader><tab>d", -- Close Tab
		modes = { "n" },
	},
	{
		key = "<leader><tab>[", -- Previous Tab
		modes = { "n" },
	},
	{
		key = "<leader>cl", -- Lsp Info
		modes = { "n" },
	},
	{
		key = "gd", -- Goto Definition
		modes = { "n" },
		action = "editor.action.revealDefinition",
	},
	{
		key = "gr", -- References
		modes = { "n" },
		action = "editor.action.goToReferences",
	},
	{
		key = "gI", -- Goto Implementation
		modes = { "n" },
		action = "editor.action.goToImplementation",
	},
	{
		key = "gy", -- Goto T[y]pe Definition
		modes = { "n" },
		action = "editor.action.goToTypeDefinition",
	},
	{
		key = "gD", -- Goto Declaration
		modes = { "n" },
	},
	{
		key = "K", -- Hover
		modes = { "n" },
		action = "editor.action.showHover",
	},
	{
		key = "gK", -- Signature Help
		modes = { "n" },
	},
	{
		key = "<c-k>", -- Signature Help
		modes = { "i" },
	},
	{
		key = "<leader>ca", -- Code Action
		modes = { "n", "v" },
		action = "editor.action.quickFix",
	},
	{
		key = "<leader>cc", -- Run Codelens
		modes = { "n", "v" },
	},
	{
		key = "<leader>cC", -- Refresh & Display Codelens
		modes = { "n" },
	},
	{
		key = "<leader>cR", -- Rename File
		modes = { "n" },
	},
	{
		key = "<leader>cr", -- Rename
		modes = { "n" },
		action = "editor.action.rename",
	},
	{
		key = "<leader>cA", -- Source Action
		modes = { "n" },
		action = "editor.action.sourceAction",
	},
	{
		key = "]]", -- Next Reference
		modes = { "n" },
		action = "editor.action.wordHighlight.next",
	},
	{
		key = "[[", -- Prev Reference
		modes = { "n" },
		action = "editor.action.wordHighlight.prev",
	},
	{
		key = "<a-n>", -- Next Reference
		modes = { "n" },
	},
	{
		key = "<a-p>", -- Prev Reference
		modes = { "n" },
	},
}

for _, binding in pairs(mappings) do
	if binding.action then
		vim.keymap.set(binding.modes, binding.key, function()
			require("vscode").action(binding.action)
		end)
	else
		pcall(function()
			vim.keymap.del(binding.modes, binding.key)
		end)
	end
end
