vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/dundalek/lazy-lsp.nvim" },
})

require("lazy-lsp").setup({
    use_vim_lsp_config = true, -- Neovim 0.11+ vim.lsp.config API

    -- Restrict JS/TS to a single server per filetype so lazy-lsp doesn't start
    -- every TS-capable server it knows (denols + biome + ...) at once.
    -- NOTE: ts_ls/eslint are configured explicitly below — in the
    -- use_vim_lsp_config path lazy-lsp drops servers whose `cmd` is a function
    -- ("dynamic cmd"), which both of these now ship. Listing them here only
    -- suppresses the other TS servers; the working configs come from in_shell().
    preferred_servers = {
        javascript = { "ts_ls", "eslint" },
        javascriptreact = { "ts_ls", "eslint" },
        typescript = { "ts_ls", "eslint" },
        typescriptreact = { "ts_ls", "eslint" },
    },
})

-- Provision typescript-language-server / eslint via nix-shell ourselves, since
-- lazy-lsp can't wrap their function `cmd`. in_shell() is the same helper
-- lazy-lsp uses, so first launch fetches the packages from nixpkgs on demand.
-- Once dynamic `cmd` support lands upstream these blocks can be removed:
-- https://github.com/dundalek/lazy-lsp.nvim/issues/63
local in_shell = require("lazy-lsp.helpers").in_shell

vim.lsp.config("ts_ls", {
    cmd = in_shell({ "typescript-language-server", "typescript" }, { "typescript-language-server", "--stdio" }),
})
vim.lsp.enable("ts_ls")

vim.lsp.config("eslint", {
    cmd = in_shell({ "vscode-langservers-extracted" }, { "vscode-eslint-language-server", "--stdio" }),
})
vim.lsp.enable("eslint")

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
