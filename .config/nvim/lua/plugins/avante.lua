return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	dependencies = { "stevearc/dressing.nvim", "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	opts = {
		windows = {
			width = 50,
		},
		hints = {
			enabled = false,
		},
		claude = {
			api_key_name = { "secret-tool", "lookup", "key", "anthropic-api-key" },
		},
	},
	specs = {
		{
			"MeanderingProgrammer/render-markdown.nvim",
			optional = true,
			opts = function(_, opts)
				opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
			end,
			ft = function(_, ft)
				vim.list_extend(ft, { "Avante" })
			end,
		},
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>a", group = "ai", mode = { "i", "v" } },
				},
			},
		},
	},
}
