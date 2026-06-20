vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/dundalek/lazy-lsp.nvim" },
})

require("lazy-lsp").setup({
    use_vim_lsp_config = true, -- Neovim 0.11+ vim.lsp.config API
})

-- References stay on the default `grr` (keeping the `gr*` prefix intact).
-- `gd`/`gI` intentionally override the built-in local-declaration / insert
-- motions.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
    callback = function(event)
        vim.keymap.set("n", "gd", function()
            Snacks.picker.lsp_definitions()
        end, { buffer = event.buf, desc = "LSP: Goto definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Goto declaration" })
        vim.keymap.set("n", "gI", function()
            Snacks.picker.lsp_implementations()
        end, { buffer = event.buf, desc = "LSP: Goto implementation" })
        vim.keymap.set("n", "gy", function()
            Snacks.picker.lsp_type_definitions()
        end, { buffer = event.buf, desc = "LSP: Goto type definition" })
        vim.keymap.set("n", "<leader>ss", function()
            Snacks.picker.lsp_symbols()
        end, { buffer = event.buf, desc = "LSP: Document symbols" })
        vim.keymap.set("n", "<leader>sS", function()
            Snacks.picker.lsp_workspace_symbols()
        end, { buffer = event.buf, desc = "LSP: Workspace symbols" })
    end,
})
