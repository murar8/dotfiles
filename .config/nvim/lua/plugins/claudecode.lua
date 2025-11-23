local toggle_key = "<C-S-/>"
return {
	"coder/claudecode.nvim",
	optional = true,
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
	},
}
