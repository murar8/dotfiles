return {
	"MagicDuck/grug-far.nvim",
	optional = true,
	---@type grug.far.OptionsOverride
	opts = {
		engines = {
			ripgrep = {
				extraArgs = "--smart-case",
			},
		},
	},
}
