-- Behavior

vim.opt.clipboard = "unnamed,unnamedplus" -- Use system clipboard.
vim.opt.confirm = true -- Prompt to save changes before exiting.
vim.opt.matchpairs:append({ "<:>" }) -- Add angle brackets to matchpairs.
vim.opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
vim.opt.wildmode = { "longest:list", "full" } -- First match longest and list all matches, then complete full string.

vim.opt.splitbelow = true -- Put new windows below current.
vim.opt.splitright = true -- Put new windows right of current.

-- Wrapping

vim.opt.breakindent = true -- Indent wrapped lines.
vim.opt.showbreak = "↪" -- String to put at the start of lines that have been wrapped.

-- Appearance

vim.opt.number = true -- Print line number.
vim.opt.scrolloff = 5 -- Keep 5 lines above and below the cursor.
vim.opt.termguicolors = true -- Use 24-bit RGB colors in the TUI.
vim.opt.title = true -- Set the title of window to the name of the file being edited.

vim.opt.cursorline = true -- Highlight the current line.
vim.opt.cursorlineopt = "number" -- Highlight the current line number.

-- Search

vim.opt.gdefault = true -- Use global substitution by default.
vim.opt.ignorecase = true -- Ignore case when searching.
vim.opt.smartcase = true -- Override ignorecase if search pattern contains uppercase characters.

-- Indentation

vim.opt.expandtab = true -- Use spaces instead of tabs.
vim.opt.shiftround = true -- Round indent to multiple of shiftwidth.
vim.opt.smartindent = true -- Insert indents automatically.

vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.

-- Undo

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Neovide

vim.opt.guifont = "Fira Code:h14" -- Set the font for Neovide.
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_animation_length = 0.01
vim.g.neovide_cursor_smooth_blink = true

-- Keybindings

vim.g.mapleader = " " -- Set <leader> as the leader key.

-- Highlight yanked text
-- https://neovim.io/doc/user/lua.html#vim.highlight

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ on_visual = false, timeout = 400 })
    end,
})

-- Go back to last editing position
-- https://github.com/creativenull/dotfiles/blob/9ae60de4f926436d5682406a5b801a3768bbc765/config/nvim/init.lua#L70-L86

vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("RestorePosition", { clear = true }),
    callback = function(args)
        local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
        local not_commit = vim.b[args.buf].filetype ~= "commit"
        if valid_line and not_commit then
            vim.cmd([[normal! g`"]])
        end
    end,
})

-- lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- https://github.com/folke/lazy.nvim#-installation
if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

require("lazy").setup({
    { import = "user.common" },
    { import = "user.terminal", cond = not vim.g.vscode },
    { import = "user.code", cond = not not vim.g.vscode },
})
