return {
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "cucumber-language-server")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		optional = true,
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
