return {
	"akinsho/bufferline.nvim",
	optional = true,
	opts = {
		options = {
			always_show_bufferline = true,
			custom_filter = function(buf_number, _)
				local path = vim.fn.bufname(buf_number)
				if path ~= "" and vim.fn.isdirectory(path) == 0 then
					return true
				end
			end,
		},
	},
}
