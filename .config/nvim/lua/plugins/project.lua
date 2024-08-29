-- Handled by project.nvim
-- See https://github.com/LazyVim/LazyVim/issues/4330
vim.g.root_spec = { "cwd" }

return {
	"ahmedkhalf/project.nvim",
	optional = true,
	lazy = false, -- See https://github.com/ahmedkhalf/project.nvim/issues/123
	opts = {
		manual_mode = false,
		lsp_ignore = { "copilot" },
		show_hidden = true,
	},
}
