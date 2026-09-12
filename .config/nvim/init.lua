-- Neovim does not create the cache dir itself; jdtls' `-data` workspace lives
-- under it (see plugins/lazy-lsp.lua).
vim.fn.mkdir(vim.fn.stdpath("cache"), "p")

require("config.options")

require("plugins.which-key")

require("config.keymaps")
require("config.autocmds")

require("plugins.gruvbox")
require("plugins.treesitter")
require("plugins.treesitter-context")
require("plugins.baredot")
require("plugins.mini-icons")
require("plugins.snacks")
require("plugins.gitsigns")
require("plugins.code-ref")
require("plugins.mini-surround")
require("plugins.mini-pairs")
require("plugins.mini-tabline")
require("plugins.mini-extra")
require("plugins.mini-ai")
require("plugins.lazy-lsp")
require("plugins.supermaven")
require("plugins.conform")
