return {
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },
    { "tpope/vim-sleuth" },
    { "windwp/nvim-autopairs",   opts = {}, event = "InsertEnter" },
    { "ahmedkhalf/project.nvim", opts = {}, main = "project_nvim" },
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "x" }, -- Start interactive EasyAlign in visual mode (e.g. vipga)
            { "ga", "<Plug>(EasyAlign)", mode = "n" }, -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
        },
    },
}
