return {
	"nvim-cmp",
	dependencies = {
		{
			"onsails/lspkind.nvim",
			after = "nvim-cmp",
			config = function()
				local cmp = require("cmp")
				local lspkind = require("lspkind")
				cmp.setup({
					---@diagnostic disable-next-line: missing-fields
					formatting = {
						format = lspkind.cmp_format({
							mode = "symbol",
							symbol_map = {
								Copilot = "", -- https://github.com/zbirenbaum/copilot-cmp?tab=readme-ov-file#highlighting--icon
							},
						}),
					},
				})
			end,
		},
	},
}
