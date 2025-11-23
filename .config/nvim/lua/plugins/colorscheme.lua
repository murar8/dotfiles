return {
	{ "folke/tokyonight.nvim", enabled = false },
	{ "catppuccin/nvim", enabled = false },
	{

		"f4z3r/gruvbox-material.nvim",
		name = "gruvbox-material",
		lazy = false,
		priority = 1000,
	},
	{
		"LazyVim/LazyVim",
		optional = true,
		opts = {
			colorscheme = "gruvbox-material",
		},
	},
}
