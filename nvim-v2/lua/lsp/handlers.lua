local M = {}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "!", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
vim.keymap.set("n", "gD", "cmd>Telescope lsp_declarations<CR>", bufopts)
vim.keymap.set("n", "K", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, bufopts)
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
-- vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)

M.capabilities = vim.lsp.protocol.make_client_capabilities()
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

-- local function lsp_keymaps(bufnr)
-- 	local opts = { noremap = true, silent = true }
-- 	local bufopts = { noremap = true, silent = true, buffer = bufnr }
-- 	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
-- 	vim.keymap.set("n", "gD", "cmd>Telescope lsp_declarations<CR>", bufopts)
-- 	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
-- 	vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
-- 	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
-- 	vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)
-- 	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
-- 	vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
-- 	vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
-- end
--
-- M.on_attach = function(client, bufnr)
-- 	lsp_keymaps(bufnr)
-- 	-- attach_navic(client, bufnr)
-- end

return M
