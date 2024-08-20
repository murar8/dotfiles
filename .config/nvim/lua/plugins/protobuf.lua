return {
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "pbls")
			table.insert(opts.ensure_installed, "clang-format")
			table.insert(opts.ensure_installed, "buf")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.sources = opts.sources or {}
			table.insert(opts.sources, nls.builtins.formatting.clang_format)
			table.insert(opts.sources, nls.builtins.diagnostics.buf)
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
