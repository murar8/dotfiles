-- https://github.com/folke/lazy.nvim/issues/1788
-- https://github.com/LazyVim/LazyVim/blob/0e46f7bfccfc91d15223e27aa189b0cb1386a861/lua/lazyvim/plugins/extras/lazyrc.lua
local root_dir = LazyVim.root()
local spec_file = root_dir .. "/.lazy.lua"
local local_spec = vim.secure.read(spec_file)
if local_spec then
	vim.api.nvim_set_current_dir(root_dir)
	package.path = package.path .. ";" .. root_dir .. "/lua/?/?.lua"
	package.path = package.path .. ";" .. root_dir .. "/lua/?/init.lua"
	package.path = package.path .. ";" .. root_dir .. "/lua/?.lua"
	vim.o.runtimepath = vim.o.runtimepath .. "," .. root_dir
	return loadstring(local_spec)()
else
	return {}
end
