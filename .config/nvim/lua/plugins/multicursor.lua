local function mc(name, args)
	return function()
		require("multicursor-nvim")[name](args)
	end
end

local function onEscape()
	local multicursor = require("multicursor-nvim")
	if not multicursor.cursorsEnabled() then
		multicursor.enableCursors()
	elseif multicursor.hasCursors() then
		multicursor.clearCursors()
	else
		vim.cmd("nohlsearch")
	end
end

return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	opts = {},
	specs = {
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>m", group = "multicursor", mode = { "n", "v" } },
				},
			},
		},
	},
	keys = {
		{ "<esc>", onEscape, mode = "n" },
		{ "<c-leftmouse>", mc("handleMouse"), mode = "n" },

		{ "<c-s-k>", mc("lineAddCursor", -1), mode = { "n", "v" }, desc = "Add Cursor Above" },
		{ "<c-s-j>", mc("lineAddCursor", 1), mode = { "n", "v" }, desc = "Add Cursor Below" },
		{ "<c-s-up>", mc("lineSkipCursor", -1), mode = { "n", "v" }, desc = "Skip Cursor Above" },
		{ "<c-s-down>", mc("lineSkipCursor", 1), mode = { "n", "v" }, desc = "Skip Cursor Below" },

		{ "<c-s-n>", mc("matchAddCursor", -1), mode = { "n", "v" }, desc = "Add Previous Match" },
		{ "<c-n>", mc("matchAddCursor", 1), mode = { "n", "v" }, desc = "Add Next Match" },
		{ "<c-s-t>", mc("matchSkipCursor", -1), mode = { "n", "v" }, desc = "Skip Previous Match" },
		{ "<c-t>", mc("matchSkipCursor", 1), mode = { "n", "v" }, desc = "Skip Next Match" },
		{ "<c-s-l>", mc("matchAllAddCursors"), mode = { "n", "v" }, desc = "Add All Matches" },

		{ "I", mc("insertVisual"), mode = "v", desc = "Insert at Visual Start" },
		{ "A", mc("appendVisual"), mode = "v", desc = "Append at Visual End" },

		{ "S", mc("splitCursors"), mode = "v", desc = "Split Cursors" },
		{ "M", mc("matchCursors"), mode = "v", desc = "Match Cursors" },

		{ "<leader>mp", mc("prevCursor"), mode = { "n", "v" }, desc = "Previous Cursor" },
		{ "<leader>mn", mc("nextCursor"), mode = { "n", "v" }, desc = "Next Cursor" },
		{ "<leader>mf", mc("firstCursor"), mode = { "n", "v" }, desc = "Go to First Cursor" },
		{ "<leader>ml", mc("lastCursor"), mode = { "n", "v" }, desc = "Go to Last Cursor" },

		{ "<leader>md", mc("deleteCursor"), mode = { "n", "v" }, desc = "Delete Cursor" },
		{ "<leader>mo", mc("toggleCursor"), mode = { "n", "v" }, desc = "Toggle Cursor" },

		{ "<leader>mc", mc("clearCursors"), mode = { "n", "v" }, desc = "Clear All Cursors" },
		{ "<leader>mu", mc("duplicateCursors"), mode = { "n", "v" }, desc = "Duplicate Cursors" },
		{ "<leader>mr", mc("restoreCursors"), mode = "n", desc = "Restore Cursors" },
		{ "<leader>ma", mc("alignCursors"), mode = "v", desc = "Align Cursors" },

		{ "<leader>mT", mc("transposeCursors", -1), mode = "v", desc = "Transpose Cursors Backward" },
		{ "<leader>mt", mc("transposeCursors", 1), mode = "v", desc = "Transpose Cursors Forward" },

		{ "<leader>mE", mc("disableCursors"), mode = { "n", "v" }, desc = "Disable Cursors" },
		{ "<leader>me", mc("enableCursors"), mode = { "n", "v" }, desc = "Enable Cursors" },
	},
}
