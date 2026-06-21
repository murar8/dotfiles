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
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

        vim.keymap.set("n", "gd", function()
            Snacks.picker.lsp_definitions()
        end, { buffer = event.buf, desc = "LSP: Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Go to declaration" })
        vim.keymap.set("n", "gI", function()
            Snacks.picker.lsp_implementations()
        end, { buffer = event.buf, desc = "LSP: Go to implementation" })
        vim.keymap.set("n", "gy", function()
            Snacks.picker.lsp_type_definitions()
        end, { buffer = event.buf, desc = "LSP: Go to type definition" })
        vim.keymap.set("n", "<leader>ss", function()
            Snacks.picker.lsp_symbols()
        end, { buffer = event.buf, desc = "LSP: Document symbols" })
        vim.keymap.set("n", "<leader>sS", function()
            Snacks.picker.lsp_workspace_symbols()
        end, { buffer = event.buf, desc = "LSP: Workspace symbols" })
    end,
})
