vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

local gitsigns = require("gitsigns")

require("which-key").add({
    { "<leader>h", group = "hunk" },
    { "<leader>t", group = "toggle" },
})

gitsigns.setup({
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                -- `Gitsigns.NavOpts` annotates every field as required, but they
                -- all fall back to the values from `setup`; spelling them out
                -- here would pin them instead.
                ---@diagnostic disable-next-line: missing-fields
                gitsigns.nav_hunk("next", { target = "all" })
            end
        end, "Next hunk")

        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                ---@diagnostic disable-next-line: missing-fields
                gitsigns.nav_hunk("prev", { target = "all" })
            end
        end, "Previous hunk")

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")

        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk")

        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected hunk")

        map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview hunk inline")

        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, "Blame line")

        map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")

        map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
        end, "Diff against last commit")

        map("n", "<leader>hQ", function()
            gitsigns.setqflist("all")
        end, "Hunks to quickfix (all buffers)")
        map("n", "<leader>hq", gitsigns.setqflist, "Hunks to quickfix")

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Current line blame")
        map("n", "<leader>tw", gitsigns.toggle_word_diff, "Word diff")

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Hunk")
    end,
})
