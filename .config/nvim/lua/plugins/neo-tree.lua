return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		close_if_last_window = true,
		filesystem = {
			bind_to_cwd = true,
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			},
		},
	},
}
