vim.cmd([[
	autocmd BufRead,BufNewFile *.env 	setfiletype env
	autocmd BufRead,BufNewFile .env.* setfiletype env
]])

return {
	"overleaf/vim-env-syntax",
}
