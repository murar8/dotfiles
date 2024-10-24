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

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
	pattern = { "*" },
	callback = function()
		local blacklist = { ".dotfiles", ".cache", ".local" }
		local root_dir = LazyVim.root()
		local home_dir = vim.fn.expand("~")
		local is_blacklisted = vim.tbl_contains(blacklist, root_dir:match("^" .. home_dir .. "/([^/]+)"))
		local is_home_hidden_folder = root_dir:match("^" .. home_dir .. "/%.") ~= nil
		if is_home_hidden_folder and not is_blacklisted then
			if vim.env.GIT_WORK_TREE ~= home_dir then
				vim.api.nvim_echo({ { "Setting git worktree to track bare dotfiles repo." } }, true, {})
				vim.env.GIT_WORK_TREE = home_dir
				vim.env.GIT_DIR = home_dir .. "/.dotfiles"
			end
		else
			vim.env.GIT_WORK_TREE = vim.v.null
			vim.env.GIT_DIR = vim.v.null
		end
	end,
})
