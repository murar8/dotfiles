return {
	"nvim-neo-tree/neo-tree.nvim",
	optional = true,
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
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].buflisted and vim.bo[buf].filetype ~= "dashboard" then
							local state = require("neo-tree.sources.manager").get_state("filesystem")
							if not require("neo-tree.sources.common.preview").is_active() then
								state.config = state.config or {}
								---@cast state neotree.StateWithTree
								state.commands.toggle_preview(state)
							end
							return
						end
					end
				end,
			},
		},
	},
}
