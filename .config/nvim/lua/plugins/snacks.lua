return {
	"folke/snacks.nvim",
	---@param opts snacks.Config
	opts = function(_, opts)
		local _ = Snacks
		opts.terminal.win.keys.term_normal = false -- disable entering terminal mode on <esc><esc>
		opts.terminal.win.position = "float"
		return opts
	end,
}
