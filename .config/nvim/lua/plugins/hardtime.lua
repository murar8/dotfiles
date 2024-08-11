return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {},
	event = { "BufRead" },
	keys = {
		{ "<leader>He", "<cmd>Hardtime enable<cr>", desc = "Enable Hardtime" },
		{ "<leader>Hd", "<cmd>Hardtime disable<cr>", desc = "Disable Hardtime" },
		{ "<leader>Ht", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
	},
}