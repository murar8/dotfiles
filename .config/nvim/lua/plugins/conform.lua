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

local function nix_formatter(pkg)
    if vim.fn.executable(pkg) == 1 then
        return nil -- already on PATH; use conform's built-in definition
    end
    local prefix = in_shell({ pkg }, { pkg })
    return {
        command = prefix[1],
        prepend_args = vim.list_slice(prefix, 2),
    }
end

local formatters = {}
for _, pkg in ipairs({ "stylua", "shfmt", "nixfmt", "prettier" }) do
    formatters[pkg] = nix_formatter(pkg)
end

local formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    nix = { "nixfmt" },
}
-- prettier for all filetypes it supports (matches LazyVim's list).
for _, ft in ipairs({
    "css",
    "graphql",
    "handlebars",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "less",
    "markdown",
    "markdown.mdx",
    "scss",
    "typescript",
    "typescriptreact",
    "vue",
    "yaml",
}) do
    formatters_by_ft[ft] = { "prettier" }
end

require("conform").setup({
    -- Fall back to LSP formatting for filetypes without a conform formatter
    -- (python/ruff, rust/rust_analyzer, toml/taplo, ... are handled by their
    -- language server, so we don't duplicate them here).
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = formatters_by_ft,
    formatters = formatters,
    format_on_save = {
        timeout_ms = 1000,
    },
})

vim.keymap.set({ "n", "x" }, "<leader>c", function()
    require("conform").format({ async = true })
end, { desc = "Format" })
