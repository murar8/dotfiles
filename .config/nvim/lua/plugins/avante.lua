return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	opts = {
		windows = {
			width = 50,
		},
		claude = {
			api_key_name = { "secret-tool", "lookup", "key", "anthropic-api-key" },
		},
	},
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"echasnovski/mini.icons",
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					use_absolute_path = true, -- required for Windows users
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			optional = true,
			ft = { "markdown", "norg", "rmd", "org", "Avante" },
			opts = {
				file_types = { "markdown", "norg", "rmd", "org", "Avante" },
			},
		},
	},
}
