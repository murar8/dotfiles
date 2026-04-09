return {
	"folke/lazydev.nvim",
	optional = true,
	opts = function(_, opts)
		vim.list_extend(opts.library, {
			{ path = "grug-far.nvim", files = { "grug-far.lua" } },
			{ path = "neo-tree.nvim", files = { "neo-tree.lua" } },
			{ path = "baredot.nvim", files = { "baredot.lua", "neo-tree.lua" } },
		})
	end,
}
