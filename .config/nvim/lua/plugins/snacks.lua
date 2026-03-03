return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		terminal = {
			win = {
				position = "float",
				keys = {
					term_normal = false, -- disable entering terminal mode on <esc><esc>
				},
			},
		},
	},
}
