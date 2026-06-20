vim.fn.mkdir(vim.fn.stdpath("cache"), "p")

require("config.options")

require("plugins.which-key")

require("config.keymaps")
require("config.autocmds")

require("plugins.gruvbox")
require("plugins.baredot")
require("plugins.mini-icons")
require("plugins.snacks")
require("plugins.claudecode")
require("plugins.mini-surround")
require("plugins.mini-tabline")
require("plugins.lazy-lsp")
require("plugins.conform")
require("plugins.nvim-lint")
