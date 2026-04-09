local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- https://lazy.folke.io/installation
if not vim.uv.fs_stat(lazypath) then
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

local is_cmd = function(cmd)
	return vim.fn.executable(cmd) == 1
end

local has_cc = is_cmd("cc") or is_cmd("gcc") or is_cmd("clang")
local has_ansible = is_cmd("ansible") or is_cmd("ansible-playbook")

local conditional_extras = {
	{ "lazyvim.plugins.extras.ai.claudecode", is_cmd("claude") },
	{ "lazyvim.plugins.extras.ai.copilot-native", vim.fn.has("nvim-0.12") == 1 and is_cmd("node") },
	{ "lazyvim.plugins.extras.editor.fzf", is_cmd("fzf") },
	{ "lazyvim.plugins.extras.formatting.prettier", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.ansible", has_ansible and is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.clangd", has_cc and is_cmd("unzip") },
	{ "lazyvim.plugins.extras.lang.docker", is_cmd("docker") and is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.go", is_cmd("go") },
	{ "lazyvim.plugins.extras.lang.json", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.markdown", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.nix", is_cmd("nix") and is_cmd("cargo") },
	{ "lazyvim.plugins.extras.lang.prisma", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.python", is_cmd("python3") and is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.rust", is_cmd("cargo") },
	{ "lazyvim.plugins.extras.lang.sql", is_cmd("python3") },
	{ "lazyvim.plugins.extras.lang.svelte", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.tailwind", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.terraform", is_cmd("terraform") and is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.typescript", is_cmd("node") },
	{ "lazyvim.plugins.extras.lang.yaml", is_cmd("node") },
	{ "lazyvim.plugins.extras.linting.eslint", is_cmd("node") },
	{ "lazyvim.plugins.extras.lsp.neoconf", is_cmd("unzip") },
	{ "lazyvim.plugins.extras.ui.treesitter-context", has_cc },
	{ "lazyvim.plugins.extras.util.dot", is_cmd("node") },
}

local spec = {
	{ "LazyVim/LazyVim" },
	{ import = "lazyvim.plugins" },

	{ import = "lazyvim.plugins.extras.coding.mini-comment" },
	{ import = "lazyvim.plugins.extras.editor.neo-tree" },
	{ import = "lazyvim.plugins.extras.coding.mini-surround" },
	{ import = "lazyvim.plugins.extras.lang.git" },
	{ import = "lazyvim.plugins.extras.lang.toml" },
	{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
}

for _, entry in ipairs(conditional_extras) do
	if entry[2] then
		spec[#spec + 1] = { import = entry[1] }
	end
end

local conditional_plugins = {
	["nvim-treesitter/nvim-treesitter"] = has_cc,
	["nvim-treesitter/nvim-treesitter-textobjects"] = has_cc,
}

for plugin, enabled in pairs(conditional_plugins) do
	if not enabled then
		spec[#spec + 1] = { plugin, enabled = false }
	end
end

spec[#spec + 1] = { import = "plugins" }

require("lazy").setup({
	spec = spec,
	change_detection = { notify = false },
	performance = {
		-- See https://github.com/NvChad/starter/blob/935ea570afe449fc86d9c88dd47eacb5c345a68e/lua/configs/lazy.lua
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"netrwPlugin",
				"rplugin",
				"spellfile_plugin",
				"tarPlugin",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
