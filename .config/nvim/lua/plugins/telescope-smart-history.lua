return {
	"nvim-telescope/telescope.nvim",
	optional = true,
	specs = {
		"nvim-telescope/telescope-smart-history.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		opts = {
			defaults = {
				history = {
					path = vim.fn.expand("~/.local/state/nvim/telescope_history.db"),
					limit = 256,
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("smart_history")
		end,
	},
}
