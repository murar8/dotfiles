-- Yank code references, adapted from yank-for-claude.nvim (MIT).
-- <leader>a* yanks Claude's `@file#L10-L20` format, <leader>y* the plain
-- `file:10-20` format. `aa`/`yy` reference the current line (normal) or
-- selection (visual), `af`/`yf` just the file. The `a` maps are always
-- cwd-relative (Claude resolves `@` refs from the cwd); the `y` maps have
-- uppercase variants (`yY`/`yF`) that yank the absolute path instead.

local STYLES = {
    claude = { prefix = "@", line = "#L", to = "-L" },
    plain = { prefix = "", line = ":", to = "-" },
}

--- @param style "claude"|"plain"
--- @param absolute boolean Use the absolute path instead of the cwd-relative one
--- @param whole_file boolean Reference the whole file (no line numbers)
local function yank_ref(style, absolute, whole_file)
    local s = STYLES[style]
    -- `%:.` is relative to the cwd, falling back to the absolute path for
    -- buffers outside it (such a ref won't resolve as an `@file`, but there is
    -- no relative form that would).
    local path = vim.fn.expand(absolute and "%:p" or "%:.")
    if path == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
    end

    local ref = s.prefix .. path
    local visual = vim.fn.mode():match("[vV\22]") ~= nil
    if not whole_file then
        -- Only read the visual anchor when actually in visual mode; in normal
        -- mode `line("v")` may return a stale mark from a previous selection.
        local cur = vim.fn.line(".")
        local anchor = visual and vim.fn.line("v") or cur
        local first, last = math.min(cur, anchor), math.max(cur, anchor)
        ref = ref .. s.line .. first
        if last > first then
            ref = ref .. s.to .. last
        end
    end

    if visual then
        vim.cmd.normal({ "\27", bang = true })
    end

    vim.fn.setreg("+", ref)
    vim.notify("Yanked: " .. ref, vim.log.levels.INFO)
end

require("which-key").add({
    { "<leader>a", group = "ai" },
    { "<leader>y", group = "yank" },
})
vim.keymap.set({ "n", "x" }, "<leader>aa", function()
    yank_ref("claude", false, false)
end, { desc = "Yank @file#L ref" })
vim.keymap.set({ "n", "x" }, "<leader>af", function()
    yank_ref("claude", false, true)
end, { desc = "Yank @file ref" })
vim.keymap.set({ "n", "x" }, "<leader>yy", function()
    yank_ref("plain", false, false)
end, { desc = "Yank file:line ref" })
vim.keymap.set({ "n", "x" }, "<leader>yf", function()
    yank_ref("plain", false, true)
end, { desc = "Yank file path" })
vim.keymap.set({ "n", "x" }, "<leader>yY", function()
    yank_ref("plain", true, false)
end, { desc = "Yank file:line ref (absolute)" })
vim.keymap.set({ "n", "x" }, "<leader>yF", function()
    yank_ref("plain", true, true)
end, { desc = "Yank file path (absolute)" })
