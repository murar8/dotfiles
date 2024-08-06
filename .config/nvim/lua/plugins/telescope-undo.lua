return {
	"debugloop/telescope-undo.nvim",
	opts = {},
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	keys = {
		{ "<leader>hu", "<cmd>Telescope undo<cr>", desc = " Undo History" },
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("undo")
	end,
}
