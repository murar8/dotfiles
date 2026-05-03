-- https://stackoverflow.com/a/16574923
-- https://github.com/alxndr/dotfiles/blob/main/nvim/lua/mappings.lua
vim.keymap.set("n", "<C-d>", [[(winheight(0)/3).'<C-d>']], { expr = true, desc = "Scroll down 1/3 window" })
vim.keymap.set("n", "<C-u>", [[(winheight(0)/3).'<C-u>']], { expr = true, desc = "Scroll up 1/3 window" })

vim.keymap.set("n", "<leader><BS>", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

if vim.fn.executable("lazydocker") == 1 then
	vim.keymap.set("n", "<leader>k", function()
		Snacks.terminal("lazydocker")
	end, { desc = "Lazydocker" })
end
