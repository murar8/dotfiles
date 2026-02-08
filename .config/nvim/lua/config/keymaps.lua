vim.keymap.set("n", "<leader><BS>", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

if vim.fn.executable("lazydocker") == 1 then
	vim.keymap.set("n", "<leader>k", function()
		Snacks.terminal("lazydocker")
	end, { desc = "Lazydocker" })
end
