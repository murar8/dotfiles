vim.keymap.set("n", "<leader><BS>", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
