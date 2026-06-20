vim.pack.add({
    { src = "https://github.com/supermaven-inc/supermaven-nvim" },
})

-- Keeps Supermaven's default keymaps (<Tab> accept, <C-]> clear, <C-j> word).
require("supermaven-nvim").setup({
    ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
})
