vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = function(ev)
		local work_tree = vim.fn.expand("~")
		local git_dir = work_tree .. "/.dotfiles"
		local root = LazyVim.root(ev.file)
		if vim.uv.fs_stat(root .. "/.git") then
			return
		end
		local command =
			{ "git", "--work-tree=" .. work_tree, "--git-dir=" .. git_dir, "ls-files", "--error-unmatch", root }
		vim.fn.system(command)
		if vim.v.shell_error == 0 then
			vim.env.GIT_WORK_TREE = work_tree
			vim.env.GIT_DIR = git_dir
		end
	end,
})
