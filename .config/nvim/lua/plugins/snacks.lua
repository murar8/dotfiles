vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

-- bare dotfiles repo has no $HOME/.git, snacks' watcher logs ENOENT
local ok, baredot = pcall(require, "baredot")
local explorer_watch = not (ok and baredot.is_enabled())

require("snacks").setup(
    {
        explorer = { enabled = true },
        terminal = {
            win = {
                position = "float",
            },
        },
        picker = {
            ui_select = true, -- route vim.ui.select through the picker
            sources = {
                files = { hidden = true },
                grep = { hidden = true },
                explorer = {
                    layout = { preview = "main" },
                    jump = { close = true },
                    hidden = true,
                    ignored = true,
                    watch = explorer_watch,
                },
            },
        },
    })

-- Files & buffers
require("which-key").add({ "<leader>f", group = "find/file" })
vim.keymap.set("n", "<leader><space>", function()
    Snacks.picker.smart()
end, { desc = "Smart find files" })
vim.keymap.set("n", "<leader>,", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", function()
    Snacks.picker.command_history()
end, { desc = "Command history" })
vim.keymap.set("n", "<leader>fb", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", function()
    Snacks.picker.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.git_files()
end, { desc = "Find files (git)" })
vim.keymap.set("n", "<leader>fr", function()
    Snacks.picker.recent()
end, { desc = "Recent files" })

-- Search
require("which-key").add({ "<leader>s", group = "search" })
vim.keymap.set("n", "<leader>sb", function()
    Snacks.picker.lines()
end, { desc = "Buffer lines" })
vim.keymap.set("n", "<leader>sB", function()
    Snacks.picker.grep_buffers()
end, { desc = "Grep open buffers" })
vim.keymap.set("n", "<leader>sg", function()
    Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
end, { desc = "Selection or word" })
vim.keymap.set("n", '<leader>s"', function()
    Snacks.picker.registers()
end, { desc = "Registers" })
vim.keymap.set("n", "<leader>s/", function()
    Snacks.picker.search_history()
end, { desc = "Search history" })
vim.keymap.set("n", "<leader>sa", function()
    Snacks.picker.autocmds()
end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sc", function()
    Snacks.picker.command_history()
end, { desc = "Command history" })
vim.keymap.set("n", "<leader>sC", function()
    Snacks.picker.commands()
end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function()
    Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function()
    Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Help pages" })
vim.keymap.set("n", "<leader>sH", function()
    Snacks.picker.highlights()
end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", function()
    Snacks.picker.icons()
end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", function()
    Snacks.picker.jumps()
end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function()
    Snacks.picker.loclist()
end, { desc = "Location list" })
vim.keymap.set("n", "<leader>sM", function()
    Snacks.picker.man()
end, { desc = "Man pages" })
vim.keymap.set("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sq", function()
    Snacks.picker.qflist()
end, { desc = "Quickfix list" })
vim.keymap.set("n", "<leader>sR", function()
    Snacks.picker.resume()
end, { desc = "Resume" })
vim.keymap.set("n", "<leader>su", function()
    Snacks.picker.undo()
end, { desc = "Undo history" })
vim.keymap.set("n", "<leader>st", function()
    Snacks.picker.todo_comments()
end, { desc = "Todo" })

-- Explorer
vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
end, { desc = "Explorer" })

-- Terminal
vim.keymap.set({ "n", "t" }, "<c-/>", function()
    Snacks.terminal()
end, { desc = "Terminal" })

-- Git
require("which-key").add({ "<leader>g", group = "git" })
vim.keymap.set("n", "<leader>gb", function()
    Snacks.picker.git_log_line()
end, { desc = "Git blame line" })
vim.keymap.set({ "n", "x" }, "<leader>go", function()
    Snacks.gitbrowse()
end, { desc = "Git browse (open)" })
if vim.fn.executable("lazygit") == 1 then
    vim.keymap.set("n", "<leader>gg", function()
        Snacks.lazygit()
    end, { desc = "Lazygit" })
end
