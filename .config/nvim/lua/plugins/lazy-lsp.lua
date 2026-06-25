vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/dundalek/lazy-lsp.nvim" },
})

-- LSP keymaps live in snacks.lua (they use Snacks pickers). This autocmd only
-- enables built-in completion on attach. `autotrigger` complements
-- 'autocomplete' (see config/options.lua): 'autocomplete' fires on keyword
-- chars, while autotrigger fires on the server's triggerCharacters (`.`, `::`,
-- `->`), which 'autocomplete' alone won't catch.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
        -- Inline color swatches for CSS-like values (default "background" style;
        -- alternatives: "foreground", "virtual").
        if client and client:supports_method("textDocument/documentColor") then
            vim.lsp.document_color.enable(true, { bufnr = event.buf })
        end
    end,
})

-- lazy-lsp installs lspconfig servers on demand via Nix (requires the Nix
-- package manager). Servers start only when a matching filetype is opened.
require("lazy-lsp").setup({
    -- Opt into the Neovim 0.11+ vim.lsp.config API (avoids the lspconfig
    -- deprecation warning). Server config goes through `configs` below.
    use_vim_lsp_config = true,
    -- Curated config: a smaller selection of recommended servers instead of
    -- enabling everything. See servers.md#curated-servers upstream.
    excluded_servers = {
        "ccls", -- prefer clangd
        "denols", -- prefer eslint and ts_ls
        "docker_compose_language_service", -- yamlls should be enough?
        "flow", -- prefer eslint and ts_ls
        "ltex", -- grammar tool using too much CPU
        "quick_lint_js", -- prefer eslint and ts_ls
        "scry", -- archived on Jun 1, 2023
        "tailwindcss", -- associates with too many filetypes
        "biome", -- not mature enough to be default
        "oxlint", -- prefer eslint
    },
    preferred_servers = {
        markdown = {},
        python = { "basedpyright", "ruff" },
    },
    -- These servers ship a function `cmd` in lspconfig (it prefers a
    -- project-local node_modules/.bin binary). The vim.lsp.config path can't
    -- nix-wrap a function, so we pin the static fallback cmd it resolves to;
    -- lazy-lsp then wraps it in the nix shell. Matches what the old lspconfig
    -- path would launch.
    configs = {
        ts_ls = { cmd = { "typescript-language-server", "--stdio" } },
        eslint = { cmd = { "vscode-eslint-language-server", "--stdio" } },
        jsonls = { cmd = { "vscode-json-language-server", "--stdio" } },
        html = { cmd = { "vscode-html-language-server", "--stdio" } },
        cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
        yamlls = { cmd = { "yaml-language-server", "--stdio" } },
        astro = { cmd = { "astro-ls", "--stdio" } },
        ruby_lsp = { cmd = { "ruby-lsp" } },
        csharp_ls = { cmd = { "csharp-ls" } },
        jdtls = { cmd = { "jdtls", "-data", vim.fn.stdpath("cache") .. "/jdtls" } },
    },
})
