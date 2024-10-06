return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	event = { "BufRead" },
	keys = {
		{ "<leader>Te", "<cmd>Hardtime enable<cr>", desc = "Enable Hardtime" },
		{ "<leader>Td", "<cmd>Hardtime disable<cr>", desc = "Disable Hardtime" },
		{ "<leader>Tt", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
	},
	opts = {
		disable_mouse = false,
		restriction_mode = "hint",
	},
	specs = {
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>H", "hardtime" },
				},
			},
		},
	},
}
