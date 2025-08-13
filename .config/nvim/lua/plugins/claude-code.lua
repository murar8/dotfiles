local toggle_key = "<C-,>"
return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	event = "VeryLazy",
	config = true,
	opts = {
		terminal = {
			---@module "snacks"
			---@type snacks.win.Config|{}
			snacks_win_opts = {
				position = "float",
				width = 0.9,
				height = 0.9,
				keys = {
					claude_hide = {
						toggle_key,
						function(self)
							self:hide()
						end,
						mode = "t",
						desc = "Hide",
					},
				},
			},
		},
	},
	keys = {
		{ toggle_key, "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>a", nil, desc = "AI/Claude Code" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ toggle_key, "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil" },
		},
		-- Diff management
		{ "<leader>ay", "<cmd>ClaudeCodeDiffApprove<cr>", desc = "Approve diff" },
		{ "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
