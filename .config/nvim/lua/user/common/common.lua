return {
    { "tpope/vim-surround" },
    { "tpope/vim-commentary" },
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "x" }, -- Start interactive EasyAlign in visual mode (e.g. vipga)
            { "ga", "<Plug>(EasyAlign)", mode = "n" }, -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
        },
    },
}
