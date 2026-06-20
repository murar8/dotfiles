vim.pack.add({
    { src = "https://github.com/mfussenegger/nvim-lint" },
})

local lint = require("lint")

lint.linters_by_ft = {
    sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("config_lint", { clear = true }),
    callback = function()
        lint.try_lint()
    end,
})
