-- Leader keys (must be set before plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI / display
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers (hybrid with number)
vim.opt.cursorline = true -- Highlight the current line
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.showmode = true -- Show mode in the command line (no statusline plugin)
vim.opt.laststatus = 3 -- Single global statusline
vim.opt.list = true -- Show invisible characters
vim.opt.conceallevel = 2 -- Hide markup except on the cursor line
vim.opt.completeopt = "menuone,noselect,popup,fuzzy" -- Completion menu without auto-select/insert, fuzzy matching

-- Editing / indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Auto-indent new lines based on syntax
vim.opt.shiftround = true -- Round indent to multiples of shiftwidth
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.virtualedit = "block" -- Cursor past line-end in visual-block mode
vim.opt.gdefault = true -- :s applies to all matches on a line by default

-- Search
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.smartcase = true -- ...unless the query has capitals
vim.opt.inccommand = "nosplit" -- Inline live preview of :substitute

-- Splits
vim.opt.splitbelow = true -- New horizontal splits go below
vim.opt.splitright = true -- New vertical splits go right

-- Scrolling
vim.opt.scrolloff = 4 -- Lines of context above/below cursor
vim.opt.smoothscroll = true -- Smooth scrolling through wrapped/long lines

-- Behavior
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.confirm = true -- Ask to save instead of erroring on :q
vim.opt.undofile = true -- Persistent undo
vim.opt.timeoutlen = 300 -- Faster mapped-sequence timeout
vim.opt.updatetime = 200 -- Idle ms before CursorHold / swap write
vim.opt.spelllang = { "en" } -- Dictionary language for :set spell
vim.opt.exrc = true -- Load project-local .nvim.lua/.nvimrc/.exrc (trust-prompted)

-- Diagnostics
vim.diagnostic.config({ jump = { float = true } }) -- Show the float when jumping with ]d/[d
