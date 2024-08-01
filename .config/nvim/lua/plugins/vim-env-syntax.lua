return {
	"overleaf/vim-env-syntax",
	init = function()
		vim.filetype.add({ pattern = { [".env.*"] = "env" } })
		vim.filetype.add({ pattern = { ["*.env"] = "env" } })
	end,
}
