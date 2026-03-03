-- https://stackoverflow.com/a/16574923
-- https://github.com/alxndr/dotfiles/blob/main/nvim/lua/mappings.lua
local scroll_down = vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-d>']], true, false, false)
local scroll_up = vim.api.nvim_replace_termcodes([[(winheight(0)/3).'<C-u>']], true, false, false)
vim.keymap.set("n", "<C-d>", scroll_down, { expr = true, desc = "Scroll down 1/3 window" })
vim.keymap.set("n", "<C-u>", scroll_up, { expr = true, desc = "Scroll up 1/3 window" })

vim.keymap.set("n", "<leader><BS>", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

if vim.fn.executable("lazydocker") == 1 then
	vim.keymap.set("n", "<leader>k", function()
		Snacks.terminal("lazydocker")
	end, { desc = "Lazydocker" })
end
