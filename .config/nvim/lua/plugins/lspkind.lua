return {
	"onsails/lspkind.nvim",
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		cmp.setup({
			---@diagnostic disable-next-line: missing-fields
			formatting = {
				format = lspkind.cmp_format({}),
			},
		})
	end,
}
