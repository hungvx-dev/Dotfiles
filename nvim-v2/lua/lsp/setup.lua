local typescript_ok, typescript = pcall(require, "typescript")
local status_ok, ufo_config = pcall(require, "plugins.nvim-ufo")
if not status_ok then
	return
end
local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local servers = {
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	"html",
	"jsonls",
	"sumneko_lua",
	"tsserver",
	"yamlls",
	"bashls",
	"volar",
	"tailwindcss",
	"stylelint_lsp",
	"dockerls",
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
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

if typescript_ok then
	typescript.setup({
		disable_commands = false, -- prevent the plugin from creating Vim commands
		debug = false, -- enable debug logging for commands
		-- LSP Config options
		server = {
			capabilities = require("lsp.servers.tsserver").capabilities,
			handlers = require("lsp.servers.tsserver").handlers,
			on_attach = function(client, bufnr)
				-- require("lsp.handlers").on_attach(client, bufnr)
				require("lsp.servers.tsserver").on_attach(client, bufnr)
			end,
		},
	})
end

local capabilities = require("lsp.handlers").capabilities

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

lspconfig.jsonls.setup({
	capabilities = capabilities,
	settings = require("lsp.servers.jsonls").settings,
})

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.volar.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- require("lsp.handlers").on_attach(client, bufnr)
		require("lsp.servers.tsserver").on_attach(client, bufnr)
	end,
	filetypes = {
		"typescriptreact",
		"vue",
	},
})

for _, server in ipairs({ "bashls", "emmet_ls", "html", "cssmodules_ls", "yamlls", "dockerls" }) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

require("ufo").setup({
	fold_virt_text_handler = ufo_config.handler,
	close_fold_kinds = { "imports", "comment" },
	preview = {
		win_config = {
			border = { "", "─", "", "", "", "─", "", "" },
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
	},
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})
