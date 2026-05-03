return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		picker = {
			sources = {
				explorer = {
					layout = { preview = "main" },
					jump = { close = true },
					hidden = true,
					ignored = true,
					watch = false, -- bare dotfiles repo has no $HOME/.git, snacks' watcher logs ENOENT
				},
			},
		},
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
