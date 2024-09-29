vim.api.nvim_create_autocmd({ "BufNew", "VimResized" }, {
	pattern = { "*" },
	callback = function()
		local scroll = math.floor(vim.fn.winheight(0) / 3)
		vim.api.nvim_set_option_value("scroll", scroll, { scope = "local" })
	end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end,
})

vim.api.nvim_create_autocmd({ "DirChanged" }, {
	pattern = { "*" },
	callback = function()
		local root = LazyVim.root()
		local home = vim.fn.expand("~")
		if string.sub(root, 0, string.len(home) + 2) == home .. "/." then
			vim.api.nvim_echo({ { "Setting git worktree to track bare dotfiles repo." } }, true, {})
			vim.env.GIT_WORK_TREE = home
			vim.env.GIT_DIR = home .. "/.dotfiles"
		else
			vim.env.GIT_WORK_TREE = vim.v.null
			vim.env.GIT_DIR = vim.v.null
		end
	end,
})
