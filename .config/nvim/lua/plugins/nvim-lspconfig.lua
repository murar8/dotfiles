return {
	"neovim/nvim-lspconfig",
	optional = true,
	opts = function(_, opts)
		opts.inlay_hints = { enabled = false }
		opts.servers.denols = {}
		return opts
	end,
}
