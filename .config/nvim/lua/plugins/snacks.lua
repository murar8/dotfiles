return {
	"folke/snacks.nvim",
	dependencies = { "baredot.nvim" },
	opts = function()
		---@type snacks.Config
		return {
			picker = {
				sources = {
					files = { hidden = true },
					grep = { hidden = true },
					explorer = {
						layout = { preview = "main" },
						jump = { close = true },
						hidden = true,
						ignored = true,
						-- bare dotfiles repo has no $HOME/.git, snacks' watcher logs ENOENT
						watch = not require("baredot").is_enabled(),
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
		}
	end,
}
