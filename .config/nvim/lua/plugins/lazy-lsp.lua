vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/dundalek/lazy-lsp.nvim" },
})

-- Teach lua_ls about the Neovim runtime and the `vim` global
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

require("lazy-lsp").setup({
    use_vim_lsp_config = true, -- Neovim 0.11+ vim.lsp.config API
})

-- Add only the binds Neovim 0.11 defaults don't already provide.
-- Defaults: K, grr, gri, grt, grn, gra, gO, [d/]d, <C-w>d, <C-]>/<C-t>.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
    callback = function(event)
        local function map(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", function()
            Snacks.picker.lsp_definitions()
        end, "Goto definition")
        map("gD", vim.lsp.buf.declaration, "Goto declaration")
        map("<leader>sS", function()
            Snacks.picker.lsp_workspace_symbols()
        end, "Workspace symbols")
        map("<leader>cf", function()
            vim.lsp.buf.format({ async = true })
        end, "Format", { "n", "x" })
    end,
})
