return {
	"nvim-telescope/telescope.nvim",
	optional = true,
	specs = {
		"debugloop/telescope-undo.nvim",
		opts = {},
		keys = {
			{ "<leader>h", "<cmd>Telescope undo<cr>", desc = "Undo History" },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
}
