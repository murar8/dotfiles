return {
	"neovim/nvim-lspconfig",
	optional = true,
	opts = function(_, opts)
		opts.inlay_hints = { enabled = false }
		return opts
	end,
}
