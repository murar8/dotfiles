vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

-- bare dotfiles repo has no $HOME/.git, snacks' watcher logs ENOENT
local explorer_watch = not require("baredot").is_enabled()

require("snacks").setup({
    explorer = { enabled = true },
    -- LSP documentHighlight of the symbol under the cursor, which also powers
    -- the ]v/[v reference jumps below. `notify_jump` echoes "1/3" on jump.
    words = { enabled = true, notify_jump = true },
    terminal = {
        win = {
            position = "float",
        },
    },
    picker = {
        ui_select = true, -- route vim.ui.select through the picker
        sources = {
            files = { hidden = true },
            grep = { hidden = true },
            explorer = {
                layout = { preview = "main" },
                jump = { close = true },
                hidden = true,
                ignored = true,
                watch = explorer_watch,
            },
        },
    },
})

--- Handler for a `Snacks.picker` source, for use as a keymap rhs.
---@param source string
---@param opts table?
local function pick(source, opts)
    return function()
        -- copied: the picker may write normalized state back into the table
        Snacks.picker[source](opts and vim.deepcopy(opts))
    end
end

-- Explorer
vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
end, { desc = "Explorer" })

-- Terminal
vim.keymap.set({ "n", "t" }, "<c-/>", function()
    Snacks.terminal()
end, { desc = "Terminal" })

-- Buffer deletion (preserves window layout, only listed buffers)
vim.keymap.set("n", "<leader><BS>", function()
    Snacks.bufdelete()
end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bo", function()
    Snacks.bufdelete.other()
end, { desc = "Delete other buffers" })
vim.keymap.set("n", "<leader>bi", function()
    Snacks.bufdelete.invisible()
end, { desc = "Delete invisible buffers" })
vim.keymap.set("n", "<leader>ba", function()
    Snacks.bufdelete.all()
end, { desc = "Delete all buffers" })

-- Git
require("which-key").add({ "<leader>g", group = "git" })
vim.keymap.set("n", "<leader>gg", function()
    Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set({ "n", "x" }, "<leader>gh", function()
    Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })
vim.keymap.set({ "n", "x" }, "<leader>gH", function()
    Snacks.gitbrowse({
        notify = false,
        open = function(url)
            vim.fn.setreg("+", url)
        end,
    })
end, { desc = "Git Browse (copy)" })

-- Jump between occurrences of the symbol under the cursor, `*`-style but
-- scope-aware: the LSP resolves what the symbol refers to, so a shadowed local
-- isn't confused with an unrelated same-named one. Current buffer only; `true`
-- cycles past the last/first match like `*` wraps. `v` because `]r`/`[r` are
-- the built-in rare-word spell motions.
vim.keymap.set("n", "]v", function()
    Snacks.words.jump(vim.v.count1, true)
end, { desc = "Next reference" })
vim.keymap.set("n", "[v", function()
    Snacks.words.jump(-vim.v.count1, true)
end, { desc = "Previous reference" })

-- git pickers
vim.keymap.set("n", "<leader>gb", pick("git_log_line"), { desc = "Git Blame Line" })
vim.keymap.set("n", "<leader>gf", pick("git_log_file"), { desc = "Git Current File History" })
vim.keymap.set("n", "<leader>gl", pick("git_log"), { desc = "Git Log" })
vim.keymap.set("n", "<leader>gd", pick("git_diff"), { desc = "Git Diff (hunks)" })
vim.keymap.set("n", "<leader>gD", pick("git_diff", { base = "origin", group = true }), { desc = "Git Diff (origin)" })
vim.keymap.set("n", "<leader>gs", pick("git_status"), { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", pick("git_stash"), { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gi", pick("gh_issue"), { desc = "GitHub Issues (open)" })
vim.keymap.set("n", "<leader>gI", pick("gh_issue", { state = "all" }), { desc = "GitHub Issues (all)" })
vim.keymap.set("n", "<leader>gp", pick("gh_pr"), { desc = "GitHub Pull Requests (open)" })
vim.keymap.set("n", "<leader>gP", pick("gh_pr", { state = "all" }), { desc = "GitHub Pull Requests (all)" })

-- Picker (top-level). `<leader>,` / `<leader>/` / `<leader>:` are LazyVim
-- shorthands for the <leader>f* / <leader>s* maps of the same source below.
vim.keymap.set("n", "<leader>,", pick("buffers"), { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", pick("grep"), { desc = "Grep" })
vim.keymap.set("n", "<leader>:", pick("command_history"), { desc = "Command History" })
vim.keymap.set("n", "<leader><space>", pick("smart"), { desc = "Find Files" })
vim.keymap.set("n", "<leader>n", pick("notifications"), { desc = "Notification History" })

-- Find
require("which-key").add({ "<leader>f", group = "find" })
vim.keymap.set("n", "<leader>fb", pick("buffers"), { desc = "Buffers" })
vim.keymap.set("n", "<leader>fB", pick("buffers", { hidden = true, nofile = true }), { desc = "Buffers (all)" })
vim.keymap.set("n", "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config") }), { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", pick("files"), { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", pick("git_files"), { desc = "Find Files (git-files)" })
vim.keymap.set("n", "<leader>fr", pick("recent"), { desc = "Recent" })
vim.keymap.set("n", "<leader>fR", pick("recent", { filter = { cwd = true } }), { desc = "Recent (cwd)" })
vim.keymap.set("n", "<leader>fp", pick("projects"), { desc = "Projects" })

-- Search / grep
require("which-key").add({ "<leader>s", group = "search" })
vim.keymap.set("n", "<leader>sb", pick("lines"), { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", pick("grep_buffers"), { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", pick("grep"), { desc = "Grep" })
vim.keymap.set("n", "<leader>sp", pick("lazy"), { desc = "Search for Plugin Spec" })
vim.keymap.set({ "n", "x" }, "<leader>sw", pick("grep_word"), { desc = "Visual selection or word" })
vim.keymap.set("n", '<leader>s"', pick("registers"), { desc = "Registers" })
vim.keymap.set("n", "<leader>s/", pick("search_history"), { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", pick("autocmds"), { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sc", pick("command_history"), { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", pick("commands"), { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", pick("diagnostics"), { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", pick("diagnostics_buffer"), { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", pick("help"), { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", pick("highlights"), { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", pick("icons"), { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", pick("jumps"), { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", pick("keymaps"), { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", pick("loclist"), { desc = "Location List" })
vim.keymap.set("n", "<leader>sM", pick("man"), { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", pick("marks"), { desc = "Marks" })
vim.keymap.set("n", "<leader>sR", pick("resume"), { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", pick("qflist"), { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>su", pick("undo"), { desc = "Undotree" })

-- ui
vim.keymap.set("n", "<leader>uC", pick("colorschemes"), { desc = "Colorschemes" })

-- LSP (LazyVim binds these per-server; mirror exactly on attach). The handlers
-- are built once here rather than per attach -- only `buffer` varies, so the
-- autocmd just rebinds the same functions in the newly attached buffer.
local lsp_keymaps = {
    { lhs = "gd", rhs = pick("lsp_definitions"), desc = "Goto Definition" },
    { lhs = "grr", rhs = pick("lsp_references"), desc = "References", nowait = true },
    { lhs = "gI", rhs = pick("lsp_implementations"), desc = "Goto Implementation" },
    { lhs = "gri", rhs = pick("lsp_implementations"), desc = "Goto Implementation" },
    { lhs = "gy", rhs = pick("lsp_type_definitions"), desc = "Goto T[y]pe Definition" },
    { lhs = "grt", rhs = pick("lsp_type_definitions"), desc = "Goto Type Definition" },
    { lhs = "<leader>ss", rhs = pick("lsp_symbols"), desc = "LSP Symbols" },
    { lhs = "<leader>sS", rhs = pick("lsp_workspace_symbols"), desc = "LSP Workspace Symbols" },
    { lhs = "gai", rhs = pick("lsp_incoming_calls"), desc = "C[a]lls Incoming" },
    { lhs = "gao", rhs = pick("lsp_outgoing_calls"), desc = "C[a]lls Outgoing" },
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("config_snacks_lsp_keymaps", { clear = true }),
    callback = function(ev)
        for _, map in ipairs(lsp_keymaps) do
            vim.keymap.set("n", map.lhs, map.rhs, { buffer = ev.buf, nowait = map.nowait, desc = map.desc })
        end
    end,
})
