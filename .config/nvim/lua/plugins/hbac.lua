return {
	{
		"axkirillov/hbac.nvim",
		config = {
			threshold = 3,
			close_buffers_with_windows = true,
			close_command = LazyVim.ui.bufremove,
		},
		specs = {
			{
				"nvim-telescope/telescope.nvim",
				optional = true,
				keys = {
					{ "<leader>fh", "<cmd>Telescope hbac buffers<CR>", desc = "HBAC buffers" },
				},
				config = function(_, opts)
					require("telescope").setup(opts)
					require("telescope").load_extension("hbac")
				end,
			},
		},
	},
}
