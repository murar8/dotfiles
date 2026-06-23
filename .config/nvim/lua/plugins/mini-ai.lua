vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.ai" },
})

local ai = require("mini.ai")
local gen_ai_spec = require("mini.extra").gen_ai_spec

ai.setup({
    n_lines = 500,
    custom_textobjects = {
        -- Whole buffer: `ag` (entire file), `ig` (trims leading/trailing blanks)
        g = gen_ai_spec.buffer(),
        -- Indent scope: `ai` (with borders), `ii` (charwise)
        i = gen_ai_spec.indent(),
        -- Diagnostic: `ad`/`id` (current buffer diagnostics)
        d = gen_ai_spec.diagnostic(),
        -- Current line: `aL` (whole line), `iL` (after indent)
        L = gen_ai_spec.line(),
        -- Number: `aN` (whole, with sign/decimal), `iN` (digits)
        N = gen_ai_spec.number(),
    },
})

-- Register text objects with which-key (operator-pending + visual modes)
require("which-key").add({
    { mode = { "o", "x" } },
    { "a", group = "around" },
    { "i", group = "inside" },
    { "ag", desc = "entire file" },
    { "ig", desc = "entire file (non-blank)" },
    { "ai", desc = "indent scope (with borders)" },
    { "ii", desc = "indent scope (charwise)" },
    { "ad", desc = "diagnostic" },
    { "id", desc = "diagnostic" },
    { "aL", desc = "line (whole)" },
    { "iL", desc = "line (after indent)" },
    { "aN", desc = "number (with sign/decimal)" },
    { "iN", desc = "number (digits)" },
})
