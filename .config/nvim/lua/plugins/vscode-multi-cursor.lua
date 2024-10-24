return {
	"vscode-neovim/vscode-multi-cursor.nvim",
	event = "VeryLazy",
	cond = not not vim.g.vscode,
	opts = {},
	keys = {
		{
			"<c-n>",
			mode = { "n", "x", "i" },
			function()
				require("vscode-multi-cursor").addSelectionToNextFindMatch()
			end,
		},
		{
			"<c-s-l>",
			mode = { "n", "x", "i" },
			function()
				require("vscode-multi-cursor").selectHighlights()
			end,
		},
	},
}

--[[ keybindings.json (VSCode)
[
	{
		"args": "<c-n>",
		"command": "vscode-neovim.send",
		"key": "ctrl+n",
		"when": "neovim.init && editorFocus"
	},
	{
		"args": "<c-s-l>",
		"command": "vscode-neovim.send",
		"key": "ctrl+shift+l",
		"when": "neovim.init && editorFocus"
	}
]
--]]
