vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.icons" },
})

require("mini.icons").setup()
-- let plugins that look for nvim-web-devicons use mini.icons instead
MiniIcons.mock_nvim_web_devicons()
