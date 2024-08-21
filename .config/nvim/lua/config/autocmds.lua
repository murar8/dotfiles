vim.api.nvim_create_autocmd({ "BufNew", "VimResized" }, {
	pattern = { "*" },
	callback = function()
		local scroll = math.floor(vim.fn.winheight(0) / 4)
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
		local cwd = vim.loop.cwd()
		if vim.uv.fs_stat(cwd .. "/.git") then
			return
		end
		local work_tree = vim.fn.expand("~")
		local git_dir = work_tree .. "/.dotfiles"
		local command =
			{ "git", "--work-tree=" .. work_tree, "--git-dir=" .. git_dir, "ls-files", "--error-unmatch", cwd }
		vim.fn.system(command)
		if vim.v.shell_error == 0 then
			vim.env.GIT_WORK_TREE = work_tree
			vim.env.GIT_DIR = git_dir
		end
	end,
})
