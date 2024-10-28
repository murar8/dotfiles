-- See https://www.lazyvim.org/configuration/recipes#supertab
-- See https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
return {
	"hrsh7th/nvim-cmp",
	optional = true,
	specs = {
		{
			"Exafunction/codeium.nvim",
			commit = "ca38490ef963b066d6f686146d73213c70ef7f6b", -- https://github.com/Exafunction/codeium.nvim/issues/256
			optional = true,
		},
	},
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		opts.mapping = vim.tbl_extend("force", opts.mapping, {
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		})
	end,
}
