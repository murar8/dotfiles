vim.pack.add({
    { src = "https://github.com/supermaven-inc/supermaven-nvim" },
})

-- Free <Tab> from Supermaven so we can layer it behind Neovim's built-in snippet
-- jump (Supermaven's own <Tab> map ignores active snippets). Binding accept to a
-- <Plug> lhs disables the real key without erroring -- unlike nil/"" -- while
-- <C-j> (accept word) and <C-]> (clear) keep their Supermaven defaults.
require("supermaven-nvim").setup({
    ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    keymaps = { accept_suggestion = "<Plug>(sm-noop)" },
})

-- <Tab> mirrors Neovim's built-in `vim.snippet.jump(1) if active, else <Tab>`,
-- with AI-accept slotted into the "else" (the gap Supermaven would otherwise
-- clobber). <S-Tab> is left entirely to the built-in backward snippet jump.
local preview = require("supermaven-nvim.completion_preview")
vim.keymap.set("i", "<Tab>", function()
    if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    elseif preview.has_suggestion() then
        preview.on_accept_suggestion()
    else
        vim.api.nvim_feedkeys(vim.keycode("<Tab>"), "n", false)
    end
end, { desc = "Snippet jump / accept AI / tab" })
