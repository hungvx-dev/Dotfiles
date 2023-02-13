-- Exported functions
local M = {}

local present, win = pcall(require, "lspconfig.ui.windows")
if not present then
	return
end

local _default_opts = win.default_opts
win.default_opts = function(options)
	local opts = _default_opts(options)
	opts.border = EcoVim.ui.float.border
	return opts
end

return M
