return {
	"overleaf/vim-env-syntax",
	lazy = false,
	init = function()
		vim.filetype.add({
			extension = { env = "env" },
			pattern = { [".env.*"] = "env" },
		})
	end,
}
