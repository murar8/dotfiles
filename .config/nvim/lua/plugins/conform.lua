vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
    },
    format_on_save = {
        timeout_ms = 1000,
    },
})

vim.keymap.set({ "n", "x" }, "<leader>c", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
