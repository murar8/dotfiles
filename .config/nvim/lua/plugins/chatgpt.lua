return {
	"jackMort/ChatGPT.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	opts = {
		api_key_cmd = "secret-tool lookup key openai-api-key",
		openai_params = { model = "gpt-4o" },
	},
	keys = {
		{ "<leader>zc", "<cmd>ChatGPT<cr>", desc = "ChatGPT" },
		{ "<leader>ze", "<cmd>ChatGPTEditWithInstruction<cr>", desc = "Edit with instruction", mode = { "n", "v" } },
		{ "<leader>zg", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction", mode = { "n", "v" } },
		{ "<leader>zt", "<cmd>ChatGPTRun translate<cr>", desc = "Translate", mode = { "n", "v" } },
		{ "<leader>zk", "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords", mode = { "n", "v" } },
		{ "<leader>zd", "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring", mode = { "n", "v" } },
		{ "<leader>za", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests", mode = { "n", "v" } },
		{ "<leader>zo", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code", mode = { "n", "v" } },
		{ "<leader>zs", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize", mode = { "n", "v" } },
		{ "<leader>zf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs", mode = { "n", "v" } },
		{ "<leader>zx", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code", mode = { "n", "v" } },
		{ "<leader>zr", "<cmd>ChatGPTRun roxygen_edit<cr>", desc = "Roxygen Edit", mode = { "n", "v" } },
		{
			"<leader>zl",
			"<cmd>ChatGPTRun code_readability_analysis<cr>",
			desc = "Code Readability Analysis",
			mode = { "n", "v" },
		},
	},
}
