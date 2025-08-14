-- Dynamic LSP server configuration based on available commands
return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		---@class opts lspconfig.options
		opts = function(_, opts)
			local arch = vim.trim(vim.fn.system("uname -m"))
			local is_arm64 = arch == "aarch64"
			local server_commands = {
				gopls = "go",
				pyright = "python3",
				rust_analyzer = "cargo",
				tsserver = "npm",
				clangd = not is_arm64,
				dockerls = "docker",
				bashls = "bash",
			}

			opts.servers = opts.servers or {}
			for server, cmd in pairs(server_commands) do
				if opts.servers[server] then
					if type(cmd) == "string" then
						opts.servers[server].enabled = vim.fn.executable(cmd) == 1
						Snacks.notify.warn("server " .. server .. " is disabled since " .. cmd .. " was not found.")
					else
						opts.servers[server].enabled = cmd
						Snacks.notify.warn("server " .. server .. " is disabled.")
					end
				end
			end

			return opts
		end,
	},
}
