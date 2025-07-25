return {
	{
		"mrcjkb/rustaceanvim",
		optional = true,
		opts = {
			server = {
				settings = {
					["rust-analyzer"] = {
						procMacro = {
							enable = true,
							-- https://github.com/LazyVim/LazyVim/issues/6111
							ignored = {},
						},
					},
				},
			},
		},
	},
}
