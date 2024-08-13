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
	performance = {
		-- See https://github.com/NvChad/starter/blob/935ea570afe449fc86d9c88dd47eacb5c345a68e/lua/configs/lazy.lua
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
