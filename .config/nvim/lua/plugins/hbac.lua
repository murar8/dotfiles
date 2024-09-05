return {
	"axkirillov/hbac.nvim",
	keys = {
		{ "<leader>pp", ":Hbac toggle_pin<cr>", desc = "Toggle pin" },
		{ "<leader>pc", ":Hbac close_unpinned<cr>", desc = "Close unpinned" },
		{ "<leader>pa", ":Hbac pin_all<cr>", desc = "Pin all" },
		{ "<leader>pu", ":Hbac unpin_all<cr>", desc = "Unpin all" },
		{ "<leader>pt", ":Hbac toggle_autoclose<cr>", desc = "Toggle autoclose" },
	},
	config = {
		threshold = 3,
		close_buffers_with_windows = true,
		close_command = LazyVim.ui.bufremove,
	},
	specs = {
		{
			"akinsho/bufferline.nvim",
			optional = true,
			opts = {
				options = {
					middle_mouse_command = function(bufnr)
						print("done")
						require("hbac.command.actions").toggle_pin(bufnr)
					end,
					name_formatter = function(buf)
						local is_pinned = require("hbac.state").is_pinned(buf.bufnr)
						if is_pinned then
							return " " .. buf.name
						else
							return nil
						end
					end,
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			optional = true,
			opts = function(_, opts)
				vim.tbl_deep_extend("keep", opts, { sections = { lualine_b = {} } })
				vim.list_extend(opts.sections.lualine_b, {
					function()
						local cur_buf = vim.api.nvim_get_current_buf()
						return require("hbac.state").is_pinned(cur_buf) and "󰐃" or "󰐄"
					end,
				})
			end,
		},
	},
}
