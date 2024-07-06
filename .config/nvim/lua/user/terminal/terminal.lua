return {
    { "tpope/vim-sleuth" },
    { "github/copilot.vim" },
    { "windwp/nvim-autopairs", opts = {}, event = "InsertEnter" },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup()
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = { theme = "gruvbox" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            ---@diagnostic disable-next-line: missing-fields
            configs.setup({ auto_install = true, highlight = { enable = true }, indent = { enable = true } })
        end,
    },
    { "williamboman/mason.nvim", opts = {} },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = { ensure_installed = { "stylua", "shfmt", "jq" } },
    },
    {
        "mhartington/formatter.nvim",
        config = function()
            local stylua = require("formatter.filetypes.lua").stylua
            local shfmt = require("formatter.filetypes.sh").shfmt
            local jq = require("formatter.filetypes.json").jq
            require("formatter").setup({
                filetype = { lua = { stylua }, sh = { shfmt }, json = { jq }, jsonc = { jq } },
            })

            vim.keymap.set("n", "<leader>fb", "<cmd>Format<CR>", { desc = "Format current buffer" })
            vim.keymap.set("n", "<leader>fw", "<cmd>FormatWrite<CR>", { desc = "Format and write current buffer" })

            vim.api.nvim_create_autocmd("BufWritePost", {
                group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
                callback = function()
                    vim.cmd([[FormatWrite]])
                end,
            })
        end,
    },
}
