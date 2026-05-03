return {
	"folke/lazydev.nvim",
	optional = true,
	opts = function(_, opts)
		vim.list_extend(opts.library, {
			{ path = "grug-far.nvim", files = { "grug-far.lua" } },
			{ path = "snacks.nvim", files = { "snacks.lua" } },
			{ path = "baredot.nvim", files = { "baredot.lua" } },
		})
	end,
}
