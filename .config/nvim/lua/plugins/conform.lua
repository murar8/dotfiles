vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

-- Run formatters through Nix (same on-demand approach lazy-lsp uses for LSP
-- servers) so the binaries don't need to be installed globally. A binary
-- already on PATH is used directly to skip the nix startup overhead.
--
-- We wrap only the binary and let conform append its built-in args, so each
-- formatter keeps its maintained flags and $FILENAME-style tokens still
-- expand. This relies on the modern `nix shell` path (args stay separate); the
-- legacy `nix-shell --run` form would swallow the appended args.
local in_shell = require("lazy-lsp.helpers").in_shell

local function nix_formatter(pkg, bin)
    if vim.fn.executable(bin) == 1 then
        return nil -- already on PATH; use conform's built-in definition
    end
    local prefix = in_shell({ pkg }, { bin })
    return {
        command = prefix[1],
        prepend_args = vim.list_slice(prefix, 2),
    }
end

require("conform").setup({
    -- Fall back to LSP formatting for filetypes without a conform formatter
    -- (python/ruff, rust/rust_analyzer, toml/taplo, ... are handled by their
    -- language server, so we don't duplicate them here).
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        -- prettier for all filetypes it supports (matches LazyVim's list).
        css = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        less = { "prettier" },
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        scss = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        yaml = { "prettier" },
    },
    formatters = {
        stylua = nix_formatter("stylua", "stylua"),
        shfmt = nix_formatter("shfmt", "shfmt"),
        prettier = nix_formatter("prettier", "prettier"),
    },
    format_on_save = {
        timeout_ms = 1000,
    },
})

vim.keymap.set({ "n", "x" }, "<leader>c", function()
    require("conform").format({ async = true })
end, { desc = "Format" })
