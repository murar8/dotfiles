return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<c-/>", "<cmd>ToggleTerm dir=" .. LazyVim.root() .. "<cr>", mode = "n", desc = "ToggleTerm" },
	},
	opts = {
		shade_terminals = false,
		open_mapping = [[<c-/>]],
		on_create = function()
			-- See https://github.com/akinsho/toggleterm.nvim/issues/527
			vim.cmd([[ setlocal signcolumn=no ]])
		end,
	},
}
