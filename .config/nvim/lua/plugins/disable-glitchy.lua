-- Disable commonly problematic LazyVim plugins (conservative)
return {
	-- noice.nvim: cmdline broken on nvim 0.11, confirmation dialogs fail,
	-- focus stealing, performance degradation from repeated autocmd creation
	{ "folke/noice.nvim", enabled = false },

	-- flash.nvim: f/t/F/T broken with dot repeat, macros fail,
	-- neovim crashes with exit code 139, broken in vue/injected languages
	{ "folke/flash.nvim", enabled = false },

	-- mini.animate: snippets malfunction, cursor position bugs,
	-- hover exits early when scrolling, neo-tree flicker on load
	{ "nvim-mini/mini.animate", enabled = false },

	-- trouble.nvim: v3 rewrite "broken and unusable" (#588),
	-- snacks.nvim incompatibility (#618), invalid buffer id crashes (#556)
	{ "folke/trouble.nvim", enabled = false },
}
