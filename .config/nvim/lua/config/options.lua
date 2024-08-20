vim.opt.gdefault = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

vim.g.root_spec = {
	{ ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "lazyvim.json" },
	"lsp",
	"cwd",
}
