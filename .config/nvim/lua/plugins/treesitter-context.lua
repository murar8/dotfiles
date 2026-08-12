-- Pins the enclosing scopes (function/class/if/loop) of the cursor position to
-- the top of the window. Uses `vim.treesitter` directly, so it works with the
-- parsers installed by `plugins.treesitter` and needs no per-language setup.

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

local tsc = require("treesitter-context")

-- Jump to the start of the innermost enclosing scope. `[c` is taken by
-- gitsigns' hunk navigation.
vim.keymap.set({ "n", "x", "o" }, "[x", function()
    tsc.go_to_context(vim.v.count1)
end, { desc = "Jump to context" })
