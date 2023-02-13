local typescript_ok, typescript = pcall(require, "typescript")
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local ufo_config_handler = require("plugins.nvim-ufo").handler

if not mason_ok or not mason_lsp_ok then
	return
end

local servers = {
	"bashls",
	"eslint",
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"html",
	"jsonls",
	"luau_lsp",
	"tsserver",
	"yamlls",
	"vuels",
	"volar",
	"prismals",
	"tailwindcss",
	"dockerls",
	"vimls",
	"stylelint_lsp",
	-- "prettier",
	-- "eslint_d",
	-- "codespell",
}

local settings = {
	ui = {
		border = EcoVim.ui.float.border or "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lsp.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local function on_attach(client, bufnr)
	-- set up buffer keymaps, etc.
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
	typescript.setup({
		disable_commands = false, -- prevent the plugin from creating Vim commands
		debug = false, -- enable debug logging for commands
		-- LSP Config options
		server = {
			capabilities = require("lsp.servers.tsserver").capabilities,
			handlers = require("lsp.servers.tsserver").handlers,
			on_attach = require("lsp.servers.tsserver").on_attach,
			settings = require("lsp.servers.tsserver").settings,
		},
	})
end

lspconfig.tailwindcss.setup({
	capabilities = require("lsp.servers.tailwindcss").capabilities,
	filetypes = require("lsp.servers.tailwindcss").filetypes,
	init_options = require("lsp.servers.tailwindcss").init_options,
	on_attach = require("lsp.servers.tailwindcss").on_attach,
	settings = require("lsp.servers.tailwindcss").settings,
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = require("lsp.servers.cssls").on_attach,
	settings = require("lsp.servers.cssls").settings,
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = require("lsp.servers.eslint").on_attach,
	settings = require("lsp.servers.eslint").settings,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = require("lsp.servers.jsonls").settings,
})

lspconfig.luau_lsp.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.vuels.setup({
	filetypes = require("lsp.servers.vuels").filetypes,
	init_options = require("lsp.servers.vuels").init_options,
	on_attach = on_attach,
})

lspconfig.volar.setup({
	capabilities = capabilities,
	filetypes = require("lsp.servers.volar").filetypes,
	on_attach = require("lsp.servers.tsserver").on_attach,
})

lspconfig.vuels.setup({
	filetypes = require("lsp.servers.vuels").filetypes,
	init_options = require("lsp.servers.vuels").init_options,
})

for _, server in ipairs({ "bashls", "emmet_ls", "html", "cssmodules_ls", "yamlls", "dockerls", "prismals" }) do
	lspconfig[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

require("ufo").setup({
	fold_virt_text_handler = ufo_config_handler,
	close_fold_kinds = { "imports", "comment" },
	preview = {
		win_config = {
			border = { "", "─", "", "", "", "─", "", "" },
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
	},
	-- provider_selector = function(bufnr, filetype, buftype)
	-- 	return { "treesitter", "indent" }
	-- end,
})
