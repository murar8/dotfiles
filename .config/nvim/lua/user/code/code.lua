return {
    "vscode-neovim/vscode-multi-cursor.nvim",
    dependencies = { "folke/flash.nvim" },
    event = "VeryLazy",
    opts = {},
    config = function()
        local plugin = require("vscode-multi-cursor")

        plugin.setup()

        -- See https://github.com/vscode-neovim/vscode-multi-cursor.nvim?tab=readme-ov-file#wrapped-vscode-commands
        vim.keymap.set({ "n", "x", "i" }, "<leader>d", function()
            plugin.addSelectionToNextFindMatch()
        end)
        vim.keymap.set({ "n", "x", "i" }, "<leader>D", function()
            plugin.addSelectionToPreviousFindMatch()
        end)
        vim.keymap.set({ "n", "x", "i" }, "<leader>l", function()
            plugin.selectHighlights()
        end)
    end,
}
