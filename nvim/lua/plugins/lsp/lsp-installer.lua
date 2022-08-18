local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local status_ok, lsp_handlers = pcall(require, "plugins.lsp.handlers")
if not status_ok then
	return
end

local servers = {
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	-- "eslint",
	"html",
	"tailwindcss",
	"jsonls",
	"sumneko_lua",
	"yamlls",
	"bashls",
	"tsserver",
	"volar",
	-- "vls",
	"graphql",
	"diagnosticls",
	"dockerls",
}

local settings = {
	ensure_installed = servers,
	ui = {
		icons = {},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
		},
	},

	log_level = vim.log.levels.INFO,
}

lsp_installer.setup(settings)
lsp_handlers.setup()

local opts = {}
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

for _, server in pairs(servers) do
	opts = {
		on_attach = lsp_handlers.on_attach,
		capabilities = lsp_handlers.capabilities,
    flags = lsp_flags,
	}

	server = vim.split(server, "@")[1]

	if server == "jsonls" then
		local jsonls_opts = require("plugins.lsp.settings.json")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "yamlls" then
		local yamlls_opts = require("plugins.lsp.settings.yamlls")
		opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
	end

	if server == "sumneko_lua" then
		local sumneko_opts = require("plugins.lsp.settings.lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "emmet_ls" then
		local emmet_ls_opts = require("plugins.lsp.settings.emmet")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

	if server == "volar" then
		local volar = require("plugins.lsp.settings.vuejs")
		opts = vim.tbl_deep_extend("force", volar, opts)

		-- filetypes = {
		-- 	"typescript",
		-- 	"javascript",
		-- 	"vue",
		-- },
	end

	lspconfig[server].setup(opts)
end

-- lspconfig["null-ls"].setup({})
-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
