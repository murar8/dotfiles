return {
	"nvim-neo-tree/neo-tree.nvim",
	optional = true,
	---@type neotree.Config
	opts = {
		close_if_last_window = false,
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
			},
		},
		event_handlers = {
			-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#auto-close-on-open-file
			{
				event = "file_open_requested",
				handler = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
			-- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/546#issuecomment-1259752317
			{
				event = "after_render",
				handler = function()
					if require("neo-tree.sources.common.preview").is_active() then
						return
					end
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].buflisted and vim.bo[buf].filetype ~= "dashboard" then
							local state = require("neo-tree.sources.manager").get_state("filesystem")
							state.config = state.config or {}
							---@cast state neotree.StateWithTree
							state.commands.toggle_preview(state)
							return
						end
					end
				end,
			},
		},
	},
	-- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/147
	config = function(_, opts)
		local baredot_ok, baredot = pcall(require, "baredot")
		if baredot_ok and baredot.is_enabled() then
			opts.filesystem.filtered_items.hide_gitignored = false
			Snacks.notify.info("Baredot: hide_gitignored disabled")
		end
		require("neo-tree").setup(opts)
	end,
}
