return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	vscode = true,
	specs = {
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>m", group = "multicursor", icon = "󰓾" },
					{ "<leader>m", group = "multicursor", icon = "󰓾", mode = "x" },
					{ "<leader>ma", icon = "󰡎" },
					{ "<leader>mc", icon = "󰆑" },
					{ "<leader>mc", icon = "󰆑", mode = "x" },
					{ "<leader>me", icon = "󰅚" },
					{ "<leader>me", icon = "󰅚", mode = "x" },
					{ "<leader>mw", icon = "󰀪" },
					{ "<leader>mw", icon = "󰀪", mode = "x" },
					{ "<leader>mo", icon = "󰁨" },
					{ "<leader>mo", icon = "󰁨", mode = "x" },
					{ "<leader>mt", icon = "󰓡", mode = "x" },
					{ "<leader>mT", icon = "󰓢", mode = "x" },
					{ "<leader>m/", icon = "󰱽" },
					{ "<leader>mn", icon = "󰐊" },
					{ "<leader>mN", icon = "󰐋" },
					{ "<leader>ms", icon = "󰒭" },
					{ "<leader>mS", icon = "󰒮" },
					{ "<leader>gv", icon = "󰁯" },
				},
			},
		},
	},
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		vim.keymap.set({ "n", "x" }, "<C-n>", function()
			mc.matchAddCursor(1)
		end, { desc = "Add cursor next match" })
		vim.keymap.set({ "n", "x" }, "<C-p>", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add cursor prev match" })

		vim.keymap.set({ "n", "x" }, "<C-A-n>", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip next match" })
		vim.keymap.set({ "n", "x" }, "<C-A-p>", function()
			mc.matchSkipCursor(-1)
		end, { desc = "Skip prev match" })

		vim.keymap.set({ "n", "x" }, "<C-A-a>", function()
			mc.matchAllAddCursors()
		end, { desc = "Add all matches" })

		vim.keymap.set({ "n", "x" }, "<C-A-j>", function()
			mc.lineAddCursor(1)
		end, { desc = "Add cursor below" })
		vim.keymap.set({ "n", "x" }, "<C-A-k>", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add cursor above" })

		vim.keymap.set({ "n", "x" }, "<C-A-S-j>", function()
			mc.lineSkipCursor(1)
		end, { desc = "Skip cursor below" })
		vim.keymap.set({ "n", "x" }, "<C-A-S-k>", function()
			mc.lineSkipCursor(-1)
		end, { desc = "Skip cursor above" })

		vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
		vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
		vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)

		vim.keymap.set("x", "S", mc.splitCursors, { desc = "Split by regex" })
		vim.keymap.set("x", "M", mc.matchCursors, { desc = "Match by regex" })
		vim.keymap.set("x", "I", mc.insertVisual, { desc = "Insert each line" })
		vim.keymap.set("x", "A", mc.appendVisual, { desc = "Append each line" })

		vim.keymap.set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement, { desc = "Increment sequence" })
		vim.keymap.set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement, { desc = "Decrement sequence" })

		vim.keymap.set("n", "gm", mc.addCursorOperator, { desc = "Add cursor operator" })

		vim.keymap.set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cursors" })

		vim.keymap.set("n", "<leader>ma", mc.alignCursors, { desc = "Align cursors" })

		vim.keymap.set({ "n", "x" }, "<leader>mc", mc.duplicateCursors, { desc = "Clone cursors" })

		vim.keymap.set({ "n", "x" }, "<leader>me", function()
			mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.ERROR })
		end, { desc = "Cursors on errors" })
		vim.keymap.set({ "n", "x" }, "<leader>mw", function()
			mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.WARN })
		end, { desc = "Cursors on warnings" })

		vim.keymap.set({ "n", "x" }, "<leader>mo", mc.operator, { desc = "Match operator" })

		vim.keymap.set("x", "<leader>mt", function()
			mc.transposeCursors(1)
		end, { desc = "Transpose forward" })
		vim.keymap.set("x", "<leader>mT", function()
			mc.transposeCursors(-1)
		end, { desc = "Transpose backward" })

		vim.keymap.set("n", "<leader>m/", mc.searchAllAddCursors, { desc = "All search results" })

		vim.keymap.set("n", "<leader>mn", function()
			mc.searchAddCursor(1)
		end, { desc = "Add cursor next search" })
		vim.keymap.set("n", "<leader>mN", function()
			mc.searchAddCursor(-1)
		end, { desc = "Add cursor prev search" })

		vim.keymap.set("n", "<leader>ms", function()
			mc.searchSkipCursor(1)
		end, { desc = "Skip next search" })
		vim.keymap.set("n", "<leader>mS", function()
			mc.searchSkipCursor(-1)
		end, { desc = "Skip prev search" })

		vim.keymap.set({ "n", "x" }, "]x", function()
			mc.diagnosticAddCursor(1)
		end, { desc = "Add cursor next diagnostic" })
		vim.keymap.set({ "n", "x" }, "[x", function()
			mc.diagnosticAddCursor(-1)
		end, { desc = "Add cursor prev diagnostic" })
		vim.keymap.set({ "n", "x" }, "]X", function()
			mc.diagnosticSkipCursor(1)
		end, { desc = "Skip next diagnostic" })
		vim.keymap.set({ "n", "x" }, "[X", function()
			mc.diagnosticSkipCursor(-1)
		end, { desc = "Skip prev diagnostic" })

		mc.addKeymapLayer(function(layerSet)
			layerSet({ "n", "x" }, "<Esc>", mc.clearCursors, { desc = "Clear cursors" })
			layerSet({ "n", "x" }, "]c", mc.nextCursor, { desc = "Next cursor" })
			layerSet({ "n", "x" }, "[c", mc.prevCursor, { desc = "Prev cursor" })
			layerSet({ "n", "x" }, "dc", mc.deleteCursor, { desc = "Delete cursor" })
		end)
	end,
}
