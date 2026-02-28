-- Dynamic LSP server configuration based on available commands
return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		dependencies = { "folke/snacks.nvim" },
		---@class opts lspconfig.options
		opts = function(_, opts)
			local arch = vim.trim(vim.fn.system("uname -m"))
			local is_arm64 = arch == "aarch64"
			local server_commands = {
				gopls = "go",
				clangd = not is_arm64,
			}

			opts.servers = opts.servers or {}
			for server, cmd in pairs(server_commands) do
				if opts.servers[server] then
					if type(cmd) == "string" and vim.fn.executable(cmd) == 0 then
						opts.servers[server].mason = false
						vim.schedule(function()
							Snacks.notify.info("server installation for " .. server .. " is disabled since " .. cmd .. " was not found.")
						end)
					elseif cmd == false then
						opts.servers[server].mason = false
						vim.schedule(function()
							Snacks.notify.info("server installation for " .. server .. " is disabled.")
						end)
					end
				end
			end

			return opts
		end,
	},
}
