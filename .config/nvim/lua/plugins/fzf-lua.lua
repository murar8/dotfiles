return {
	"ibhagwan/fzf-lua",
	optional = true,
	keys = {
		{ "<leader>sf", "<cmd>FzfLua resume<cr>", desc = "Resume" },
	},
	opts = {
		fzf_opts = {
			["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
		},
	},
}
