-- Enter insert mode automatically in terminal buffers
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("config_term_insert", { clear = true }),
    callback = function()
        if vim.bo.buftype == "terminal" then
            vim.cmd.startinsert()
        end
    end,
})

-- Auto-close the terminal buffer when its process exits
vim.api.nvim_create_autocmd("TermClose", {
    desc = "Dismiss hit-enter prompt on terminal exit",
    group = vim.api.nvim_create_augroup("config_term_close", { clear = true }),
    callback = function()
        -- nvim raises a hit-enter prompt on non-zero exit; dismiss it.
        if vim.v.event.status ~= 0 then
            vim.api.nvim_input("<CR>")
            vim.api.nvim_input("<CR>")
        end
    end,
})

-- Disable 'autocomplete' (config/options.lua) in prompt inputs so the menu
-- doesn't pop over picker/ui.input text (e.g. Snacks grep on <leader>sg).
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("config_no_autocomplete_prompt", { clear = true }),
    callback = function(event)
        if vim.bo[event.buf].buftype == "prompt" then
            vim.bo[event.buf].autocomplete = false
        end
    end,
})

-- Highlight text on yank
-- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/config/autocmds.lua#L18-L27
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("config_highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Enable wrap and spell in prose filetypes
-- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/config/autocmds.lua#L103-L110
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("config_wrap_spell", { clear = true }),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Restore cursor to last edit position when reopening a buffer
-- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/config/autocmds.lua#L40-L55
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("config_last_loc", { clear = true }),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
        end
        vim.b[buf].last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Reload a file when it changed on disk
-- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/config/autocmds.lua#L8-L15
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("config_checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})
