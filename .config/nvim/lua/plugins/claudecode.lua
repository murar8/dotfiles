vim.pack.add({
    { src = "https://github.com/coder/claudecode.nvim" },
})

require("claudecode").setup({
    terminal = {
        provider = "none", -- Disable terminal management, use external Claude
    },
})

require("which-key").add({ "<leader>a", group = "ai/claude" })
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

-- Add the file/tree under the cursor from explorer & picker buffers
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("config_claudecode_tree_add", { clear = true }),
    pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    callback = function(event)
        vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = event.buf, desc = "Add file" })
    end,
})
