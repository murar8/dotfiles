vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- LSP keymaps live in snacks.lua (they use Snacks pickers). This autocmd only
-- enables built-in completion on attach.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
    end,
})
