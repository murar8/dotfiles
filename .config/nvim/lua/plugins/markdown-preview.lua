-- https://github.com/iamcco/markdown-preview.nvim/issues/690#issuecomment-2510492642
return {
	"iamcco/markdown-preview.nvim",
	optional = true,
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = ":call mkdp#util#install()",
}
