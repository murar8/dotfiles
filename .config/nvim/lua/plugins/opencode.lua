return {
	{
		"NickvanDyke/opencode.nvim",
		specs = {
			{ "coder/claudecode.nvim", optional = true, enabled = false },
			{
				"folke/which-key.nvim",
				optional = true,
				opts = {
					spec = {
						{ "<leader>a", group = "ai", icon = "󰚩", mode = { "n", "v" } },
						{ "<leader>aa", icon = "󰭹", mode = { "n", "v" } },
						{ "<leader>ax", icon = "󰘖", mode = { "n", "v" } },
						{ "<leader>ao", icon = "󰒅", mode = { "n", "x" } },
						{ "<leader>al", icon = "󰘍" },
						{ "<leader>ad", icon = "󰒡" },
						{ "<leader>ag", icon = "󰊢" },
						{ "<leader>ab", icon = "󰈔" },
						{ "<leader>aB", icon = "󰈢" },
						{ "<leader>av", icon = "󰈈" },
						{ "<leader>aq", icon = "󰁨" },
						{ "<leader>am", icon = "󰃀" },
					},
				},
			},
		},
		config = function()
			-- Required for auto-reload when opencode edits files
			vim.o.autoread = true
			vim.g.opencode_opts = {
				provider = {
					enabled = false, -- Disable terminal management, use external opencode
				},
				events = {
					permissions = {
						enabled = false, -- Disable permission prompts, use TUI instead
					},
				},
			}
		end,
		keys = {
			{ "<leader>a", mode = { "n", "v" }, desc = "+ai" },
			{
				"<leader>aa",
				mode = { "n", "v" },
				desc = "Ask",
				function()
					require("opencode").prompt("@this")
				end,
			},
			{
				"<leader>ax",
				mode = { "n", "v" },
				desc = "Actions",
				function()
					require("opencode").select()
				end,
			},
			{
				"<leader>ao",
				mode = { "n", "x" },
				desc = "Operator",
				expr = true,
				function()
					return require("opencode").operator("@this ")
				end,
			},
			{
				"<leader>al",
				desc = "Line",
				expr = true,
				function()
					return require("opencode").operator("@this ") .. "_"
				end,
			},
			{
				"<leader>ad",
				desc = "Diagnostics",
				function()
					require("opencode").prompt("@diagnostics")
				end,
			},
			{
				"<leader>ag",
				desc = "Diff",
				function()
					require("opencode").prompt("@diff")
				end,
			},
			{
				"<leader>ab",
				desc = "Buffer",
				function()
					require("opencode").prompt("@buffer")
				end,
			},
			{
				"<leader>aB",
				desc = "Buffers",
				function()
					require("opencode").prompt("@buffers")
				end,
			},
			{
				"<leader>av",
				desc = "Visible",
				function()
					require("opencode").prompt("@visible")
				end,
			},
			{
				"<leader>aq",
				desc = "Quickfix",
				function()
					require("opencode").prompt("@quickfix")
				end,
			},
			{
				"<leader>am",
				desc = "Marks",
				function()
					require("opencode").prompt("@marks")
				end,
			},
		},
	},
}
