return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "cucumber-language-server")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				cucumber_language_server = {
					settings = {
						cucumber = {
							features = { "test/features/**/*.feature" },
							glue = { "test/steps/**/*.ts" },
						},
					},
				},
			},
		},
	},
}
