return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	specs = {
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>m", "multicursor" },
				},
			},
		},
	},
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		vim.keymap.set({ "n" }, "<leader>ma", mc.alignCursors, { desc = "Align cursors" })
		vim.keymap.set({ "n" }, "<leader>ms", mc.searchAllAddCursors, { desc = "Search all add cursors" })
		vim.keymap.set({ "n" }, "<leader>mr", mc.restoreCursors, { desc = "Restore cursors" })
		vim.keymap.set({ "x" }, "<leader>mm", mc.matchCursors, { desc = "Match cursors within selection by Regex" })

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
				mc.matchSkipCursor(1)
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
