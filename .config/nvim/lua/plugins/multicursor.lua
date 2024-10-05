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
					{ "\\\\", group = "multicursor", mode = { "n", "v" } },
				},
			},
		},
	},
	keys = {
		{ "<esc>", onEscape, mode = "n" },
		{ "<c-leftmouse>", mc("handleMouse"), mode = "n" },

		{ "<c-s-k>", mc("lineAddCursor", -1), mode = { "n", "v" }, desc = "Add Cursor Above" },
		{ "<c-s-j>", mc("lineAddCursor", 1), mode = { "n", "v" }, desc = "Add Cursor Below" },

		{ "<c-s-n>", mc("matchAddCursor", -1), mode = { "n", "v" }, desc = "Add Previous Match" },
		{ "<c-n>", mc("matchAddCursor", 1), mode = { "n", "v" }, desc = "Add Next Match" },
		{ "<c-s-l>", mc("matchAllAddCursors"), mode = { "n", "v" }, desc = "Add All Matches" },

		{ "I", mc("insertVisual"), mode = "v", desc = "Insert at Visual Start" },
		{ "A", mc("appendVisual"), mode = "v", desc = "Append at Visual End" },

		{ "S", mc("splitCursors"), mode = "v", desc = "Split Cursors" },
		{ "M", mc("matchCursors"), mode = "v", desc = "Match Cursors" },

		{ "\\\\L", mc("lineSkipCursor", -1), mode = { "n", "v" }, desc = "Skip Cursor Above" },
		{ "\\\\l", mc("lineSkipCursor", 1), mode = { "n", "v" }, desc = "Skip Cursor Below" },

		{ "\\\\S", mc("matchSkipCursor", -1), mode = { "n", "v" }, desc = "Skip Previous Match" },
		{ "\\\\s", mc("matchSkipCursor", 1), mode = { "n", "v" }, desc = "Skip Next Match" },

		{ "\\\\N", mc("prevCursor"), mode = { "n", "v" }, desc = "Previous Cursor" },
		{ "\\\\n", mc("nextCursor"), mode = { "n", "v" }, desc = "Next Cursor" },
		{ "\\\\F", mc("firstCursor"), mode = { "n", "v" }, desc = "Go to First Cursor" },
		{ "\\\\f", mc("lastCursor"), mode = { "n", "v" }, desc = "Go to Last Cursor" },

		{ "\\\\d", mc("deleteCursor"), mode = { "n", "v" }, desc = "Delete Cursor" },
		{ "\\\\t", mc("toggleCursor"), mode = { "n", "v" }, desc = "Toggle Cursor" },
		{ "\\\\c", mc("clearCursors"), mode = { "n", "v" }, desc = "Clear All Cursors" },
		{ "\\\\d", mc("duplicateCursors"), mode = { "n", "v" }, desc = "Duplicate Cursors" },
		{ "\\\\r", mc("restoreCursors"), mode = "n", desc = "Restore Cursors" },
		{ "\\\\a", mc("alignCursors"), mode = "v", desc = "Align Cursors" },

		{ "\\\\t", mc("transposeCursors", 1), mode = "v", desc = "Transpose Cursors Forward" },
		{ "\\\\T", mc("transposeCursors", -1), mode = "v", desc = "Transpose Cursors Backward" },

		{ "\\\\D", mc("enableCursors"), mode = { "n", "v" }, desc = "Enable Cursors" },
		{ "\\\\d", mc("disableCursors"), mode = { "n", "v" }, desc = "Disable Cursors" },
	},
}
