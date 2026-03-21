vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end,
})

-- Auto-close terminal buffer when process exits
-- https://github.com/neovim/neovim/issues/14986#issuecomment-902705190
vim.api.nvim_create_autocmd("TermClose", {
	callback = function(ev)
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(ev.buf) then
				vim.api.nvim_buf_delete(ev.buf, { force = true })
			end
		end)
	end,
})
