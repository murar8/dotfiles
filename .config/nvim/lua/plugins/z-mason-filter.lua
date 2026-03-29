-- Disable Mason installs for tools whose build dependencies are missing
return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		dependencies = { "folke/snacks.nvim" },
		opts = function(_, opts)
			local arch = vim.trim(vim.fn.system("uname -m"))
			local is_arm64 = arch == "aarch64"
			local server_commands = {
				gopls = "go",
				nil_ls = "cargo",
				pbls = "cargo",
				clangd = not is_arm64,
			}

			opts.servers = opts.servers or {}
			for server, cmd in pairs(server_commands) do
				if opts.servers[server] then
					if type(cmd) == "string" and vim.fn.executable(cmd) == 0 then
						opts.servers[server].mason = false
						vim.schedule(function()
							Snacks.notify.info(
								"server installation for " .. server .. " is disabled since " .. cmd .. " wasn't found."
							)
						end)
					elseif cmd == false then
						opts.servers[server].mason = false
						vim.schedule(function()
							Snacks.notify.info("server installation for " .. server .. " is disabled.")
						end)
					end
				end
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		optional = true,
		opts = function(_, opts)
			-- Filter out tools whose build commands are missing
			local tool_commands = {
				gofumpt = "go",
				goimports = "go",
				pbls = "cargo",
			}

			opts.ensure_installed = vim.tbl_filter(function(tool)
				local cmd = tool_commands[tool]
				if cmd and vim.fn.executable(cmd) == 0 then
					vim.schedule(function()
						Snacks.notify.info(
							"Mason install for " .. tool .. " is disabled since " .. cmd .. " wasn't found."
						)
					end)
					return false
				end
				return true
			end, opts.ensure_installed or {})
		end,
	},
}
