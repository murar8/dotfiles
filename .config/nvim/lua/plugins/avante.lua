return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	dependencies = { "stevearc/dressing.nvim", "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	opts = {
		provider = "claude",
		windows = {
			width = 50,
		},
		hints = {
			enabled = false,
		},
		claude = {
			temperature = 0,
			api_key_name = { "secret-tool", "lookup", "key", "anthropic-api-key" },
		},
		openai = {
			endpoint = "https://api.deepseek.com/v1",
			model = "deepseek-chat",
			temperature = 0,
			api_key_name = { "secret-tool", "lookup", "key", "deepseek-api-key" },
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
