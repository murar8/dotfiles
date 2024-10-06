return {
	"mbbill/undotree",
	init = function()
		vim.g.undotree_DiffpanelHeight = 12
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_SetFocusWhenToggle = true
	end,
	keys = {
		{ "<leader>y", vim.cmd.UndotreeToggle, desc = "Undo tree" },
	},
}
