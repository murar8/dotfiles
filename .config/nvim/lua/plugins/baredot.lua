vim.pack.add({
    { src = "https://plugins.ejri.dev/baredot.nvim" },
})

---@type BaredotConfig
require("baredot").setup({
    git_dir = "~/.dotfiles",
    disable_pattern = "^%.git$",
})
