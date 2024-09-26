local function handleMouse()
	require("multicursor-nvim").handleMouse()
end

local function addCursorBelow()
	require("multicursor-nvim").addCursor("j")
end

local function addCursorAbove()
	require("multicursor-nvim").addCursor("k")
end

local function addCursorNext()
	require("multicursor-nvim").addCursor("*")
end

local function skipCursorNext()
	require("multicursor-nvim").skipCursor("*")
end

local function nextCursor()
	require("multicursor-nvim").nextCursor()
end

local function prevCursor()
	require("multicursor-nvim").prevCursor()
end

local function deleteCursor()
	require("multicursor-nvim").deleteCursor()
end

local function clearCursors()
	require("multicursor-nvim").clearCursors()
end

local function alignCursors()
	require("multicursor-nvim").alignCursors()
end

local function splitCursors()
	require("multicursor-nvim").splitCursors()
end

local function matchCursors()
	require("multicursor-nvim").matchCursors()
end

local function transposeCursorsClockwise()
	require("multicursor-nvim").transposeCursors(1)
end

local function transposeCursorsAntiClockwise()
	require("multicursor-nvim").transposeCursors(-1)
end

local function insertVisual()
	require("multicursor-nvim").insertVisual()
end

local function appendVisual()
	require("multicursor-nvim").appendVisual()
end

return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	opts = {},
	keys = {
		{ "<c-leftmouse>", handleMouse },
		{ "<leader>ma", alignCursors, mode = "n", desc = "Align cursor columns." },
		{ "<leader>md", deleteCursor, mode = { "n", "v" }, desc = "Delete the main cursor." },
		{ "<leader>mD", clearCursors, mode = { "n", "v" }, desc = "Clear all cursors." },
		{ "<c-s-j>", addCursorBelow, mode = { "n", "v" }, desc = "Add cursor below." },
		{ "<c-s-k>", addCursorAbove, mode = { "n", "v" }, desc = "Add cursor above." },
		{
			"<c-n>",
			addCursorNext,
			mode = { "n", "v" },
			desc = "Add a cursor and jump to the next word under the cursor.",
		},
		{
			"<c-s-n>",
			skipCursorNext,
			mode = { "n", "v" },
			desc = "Jump to the next word under the cursor without adding a cursor.",
		},
		{ "<leader>mn", nextCursor, mode = { "n", "v" }, desc = "Select the next cursor." },
		{ "<leader>mN", prevCursor, mode = { "n", "v" }, desc = "Select the previous cursor." },
		{
			"<leader>mt",
			transposeCursorsClockwise,
			mode = "v",
			desc = "Rotate visual selection contents clockwise.",
		},
		{
			"<leader>mT",
			transposeCursorsAntiClockwise,
			mode = "v",
			desc = "Rotate visual selection contents anti-clockwise.",
		},
		{ "S", splitCursors, mode = "v", desc = "Split visual selections by regex." },
		{ "M", matchCursors, mode = "v", desc = "Match new cursors within visual selections by regex." },
		{ "I", insertVisual, mode = "v", desc = "Insert for each line of visual selections." },
		{ "A", appendVisual, mode = "v", desc = "Append for each line of visual selections." },
	},
}
