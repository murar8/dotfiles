LazyVim.safe_keymap_set("n", "<leader><BS>", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
LazyVim.safe_keymap_set("t", "<C-\\>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })
vim.keymap.del("t", "<esc><esc>")
