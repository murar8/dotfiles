vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.cmd.startinsert()
		end
	end,
})

-- Auto-close terminal buffer when process exits
-- https://github.com/neovim/neovim/issues/14986#issuecomment-902705190
vim.api.nvim_create_autocmd("TermClose", {
	callback = function()
		-- Dismiss the hit-enter prompt nvim raises on a non-zero exit.
		-- https://github.com/neovim/neovim/issues/14986#issuecomment-902845083
		if vim.v.event.status ~= 0 then
			vim.api.nvim_input("<CR>")
			vim.api.nvim_input("<CR>")
		end
	end,
})
