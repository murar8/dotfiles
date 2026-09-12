vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.ai" },
})

local gen_ai_spec = require("mini.extra").gen_ai_spec

-- Each entry drives both mini.ai's `custom_textobjects` and the which-key
-- descriptions below, so a new textobject is a single edit.
local textobjects = {
    { key = "g", spec = gen_ai_spec.buffer(), around = "entire file", inside = "entire file (non-blank)" },
    {
        key = "i",
        spec = gen_ai_spec.indent(),
        around = "indent scope (with borders)",
        inside = "indent scope (charwise)",
    },
    { key = "d", spec = gen_ai_spec.diagnostic(), around = "diagnostic", inside = "diagnostic" },
    { key = "L", spec = gen_ai_spec.line(), around = "line (whole)", inside = "line (after indent)" },
    { key = "N", spec = gen_ai_spec.number(), around = "number (with sign/decimal)", inside = "number (digits)" },
}

local custom_textobjects = {}
local which_key_spec = {
    { mode = { "o", "x" } },
    { "a", group = "around" },
    { "i", group = "inside" },
}
for _, obj in ipairs(textobjects) do
    custom_textobjects[obj.key] = obj.spec
    table.insert(which_key_spec, { "a" .. obj.key, desc = obj.around })
    table.insert(which_key_spec, { "i" .. obj.key, desc = obj.inside })
end

require("mini.ai").setup({
    n_lines = 500,
    custom_textobjects = custom_textobjects,
})

-- Register text objects with which-key (operator-pending + visual modes)
require("which-key").add(which_key_spec)
