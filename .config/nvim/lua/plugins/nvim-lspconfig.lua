return {
	"neovim/nvim-lspconfig",
	optional = true,
	opts = function(_, opts)
		opts.inlay_hints = { enabled = false }

		opts.servers.denols = {}

		-- Check if the ESP-IDF environment variable is set
		local esp_idf_path = os.getenv("IDF_PATH")
		if esp_idf_path then
			-- for esp-idf
			opts.servers.clangd = {
				cmd = {
					"/home/lmurarotto/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd",
					"--background-index",
					"--query-driver=**",
				},
			}
		end

		return opts
	end,
}
