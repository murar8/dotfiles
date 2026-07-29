-- nvim-treesitter `main` branch installs parsers and queries; the features
-- themselves (highlighting, folds, indentation) are enabled per buffer in the
-- FileType autocmd below. The plugin does not support lazy-loading.
--
-- Requires `tar`, `curl`, a C compiler and tree-sitter-cli (>= 0.26.1) on PATH.

-- Parsers are pinned to revisions in the plugin's manifest, so they have to be
-- rebuilt whenever the plugin itself changes. Registered before `pack.add` so
-- that the initial install is caught too.
vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("config_treesitter_update", { clear = true }),
    callback = function(event)
        local data = event.data
        if data.spec.name ~= "nvim-treesitter" or (data.kind ~= "install" and data.kind ~= "update") then
            return
        end
        -- On a fresh install the plugin is not on 'runtimepath' yet, so :TSUpdate
        -- would not exist.
        if not data.active then
            vim.cmd.packadd("nvim-treesitter")
        end
        vim.cmd.TSUpdate()
    end,
})

-- `main` is the current default branch, but pin it: the `master` branch is the
-- old, incompatible version of this plugin.
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local ts = require("nvim-treesitter")

-- Injections need a parser for the injected language, and these are never a
-- filetype of their own (`luadoc`/`luap`/`printf` inside lua, `jsdoc`/`regex`
-- inside js/ts), so the FileType autocmd below can never trigger their install.
-- Fetch them up front instead; a no-op once they are present.
--
-- Injected languages that *are* filetypes (bash in nix, css in html, ...) are
-- covered by the autocmd as soon as any such file is opened, and `c`, `vim`,
-- `query`, `markdown_inline` ship with Neovim.
ts.install({ "luadoc", "luap", "printf", "jsdoc", "regex" })

--- Enable treesitter features for `buf`, if a parser for `lang` is available.
---@param buf integer
---@param lang string
---@return boolean attached `false` when no parser is installed for `lang`.
local function attach(buf, lang)
    -- Searches all of 'runtimepath', so this covers parsers from any source, not
    -- just the ones nvim-treesitter installed.
    if not vim.treesitter.language.add(lang) then
        return false
    end

    vim.treesitter.start(buf, lang)

    vim.api.nvim_buf_call(buf, function()
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
    end)

    -- Treesitter indentation is experimental and only some languages ship an
    -- `indents` query; without one, indentexpr would return -1 for every line
    -- and lose Neovim's built-in indenting.
    if vim.treesitter.query.get(lang, "indents") then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    return true
end

-- `get_available()` dispatches a `User TSUpdate` autocmd and then builds and
-- sorts a list of every known parser (~300), so it is kept out of the per-buffer
-- path: built at most once, on the first filetype with no installed parser.
local available ---@type table<string, true>?

---@param lang string
---@return boolean
local function is_available(lang)
    if not available then
        available = {}
        for _, name in ipairs(ts.get_available()) do
            available[name] = true
        end
    end
    return available[lang] == true
end

-- Languages we already tried to fetch. A successful install is visible to
-- `attach`, so in practice this remembers the failures, keeping a parser that
-- cannot be built from being retried by every subsequent buffer.
local requested = {} ---@type table<string, true>

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("config_treesitter_start", { clear = true }),
    callback = function(event)
        -- Parser names are not filetypes (`typescriptreact` -> `tsx`); the
        -- mapping lives in Neovim's language registry. Only nil for empty ft.
        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang or attach(event.buf, lang) then
            return
        end

        if requested[lang] or not is_available(lang) then
            return
        end
        requested[lang] = true

        -- Install on demand; the buffer lights up once the parser is built.
        ts.install(lang):await(vim.schedule_wrap(function(err, ok)
            -- A failed build is reported as `false` rather than an error, and
            -- either way the buffer would otherwise stay silently unhighlighted.
            if err or not ok then
                vim.notify(
                    ("nvim-treesitter: failed to install parser for %q (:TSLog for details)"):format(lang),
                    vim.log.levels.WARN
                )
            elseif vim.api.nvim_buf_is_valid(event.buf) then
                attach(event.buf, lang)
            end
        end))
    end,
})
