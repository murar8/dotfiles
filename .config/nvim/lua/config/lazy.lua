local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- https://lazy.folke.io/installation
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Error cloning lazy.nvim: ", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
    vim.fn.getchar()
    os.exit(1)
	end
end

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim" },
		{ import = "lazyvim.plugins" },
		{ import = "plugins" },
	},
	change_detection = { notify = false },
	checker = { enabled = true },
	defaults = {
		version = false, -- always use the latest git commit
	},
	performance = {
		rtp = {
			-- See http://www.lazyvim.org/configuration/lazy.nvim
			-- Not sure if this is necessary.
			disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
		},
	},
})
