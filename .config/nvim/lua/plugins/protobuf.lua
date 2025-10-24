return {
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "pbls")
			table.insert(opts.ensure_installed, "clang-format")
			table.insert(opts.ensure_installed, "buf")
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				proto = { "clang_format" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				proto = { "buf_lint" },
			},
		},
	},
}
