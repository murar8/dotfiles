return {
	{
		"mrcjkb/rustaceanvim",
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

