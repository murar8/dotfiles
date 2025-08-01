return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	specs = {
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>m", group = "multicursor", icon = "󰓾" },
					{ "<leader>ma", desc = "Align cursors", icon = "󰮗" },
					{ "<leader>ms", desc = "Add cursors by search", icon = " " },
					{ "<leader>mr", desc = "Restore cursors", icon = "󰁯" },
					{ "<leader>mm", desc = "Match by regex", icon = "󰑑" },
					{ "gl", desc = "Add cursor on motion", icon = "󰓾" },
				},
			},
		},
	},
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		vim.keymap.set("x", "I", mc.insertVisual)
		vim.keymap.set("x", "A", mc.appendVisual)

		vim.keymap.set("n", "gl", mc.addCursorOperator)

		vim.keymap.set({ "n" }, "<leader>ma", mc.alignCursors, {})
		vim.keymap.set({ "n" }, "<leader>ms", mc.searchAllAddCursors, {})
		vim.keymap.set({ "n" }, "<leader>mr", mc.restoreCursors, {})
		vim.keymap.set({ "x" }, "<leader>mm", mc.matchCursors, {})

		vim.keymap.set({ "n" }, "<c-s-j>", function()
			mc.lineAddCursor(1)
		end)
		vim.keymap.set({ "n" }, "<c-s-k>", function()
			mc.lineAddCursor(-1)
		end)

		vim.keymap.set({ "n" }, "<c-s-a-j>", function()
			mc.lineSkipCursor(1)
		end)
		vim.keymap.set({ "n" }, "<c-s-a-k>", function()
			mc.lineSkipCursor(-1)
		end)

		vim.keymap.set({ "n", "x" }, "<c-a-n>", function()
			if mc.cursorsEnabled() then
				mc.matchAddCursor(-1)
			else
				mc.enableCursors()
			end
		end)
		vim.keymap.set({ "n", "x" }, "<c-n>", function()
			if mc.cursorsEnabled() then
				mc.matchAddCursor(1)
			else
				mc.enableCursors()
			end
		end)

		vim.keymap.set({ "n", "x" }, "<c-a-m>", function(fallback)
			if mc.cursorsEnabled() then
				mc.matchSkipCursor(-1)
			else
				fallback()
			end
		end)
		vim.keymap.set({ "n", "x" }, "<c-m>", function(fallback)
			if mc.cursorsEnabled() then
				mc.matchSkipCursor(1)
			else
				fallback()
			end
		end)

		-- Add and remove cursors with control + left click.
		vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
		vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
		vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)

		mc.addKeymapLayer(function(layerSet)
			layerSet({ "n", "x" }, "<c-s-h>", mc.prevCursor)
			layerSet({ "n", "x" }, "<c-s-l>", mc.nextCursor)

			layerSet("n", "<esc>", function(fallback)
				if not mc.cursorsEnabled() then
					fallback()
				else
					mc.clearCursors()
				end
			end)
		end)
	end,
}
