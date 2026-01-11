return {
	"coder/claudecode.nvim",
	optional = true,
	opts = {
		terminal = {
			provider = "none", -- Disable terminal management, use external Claude
		},
	},
	keys = {
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
	},
}
