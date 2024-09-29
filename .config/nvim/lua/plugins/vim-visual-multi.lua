return {
	"mg979/vim-visual-multi",
	lazy = false,
	init = function()
		vim.g.VM_maps = {
			["Add Cursor Down"] = "<C-S-j>", -- <C-Down>
			["Add Cursor Up"] = "<C-S-k>", -- <C-Up>
			["Undo"] = "u", -- <>
			["Redo"] = "<C-r>", -- <>
		}
	end,
}
