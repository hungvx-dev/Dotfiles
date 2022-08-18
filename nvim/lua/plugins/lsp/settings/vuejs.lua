local lspconfig_configs = require("lspconfig.configs")
local lspconfig_util = require("lspconfig.util")

-- local script_path = os.getenv("HOME") .. "/.local/src/volar/node_modules/@volar/server/out/index.js"
-- local tslib_path = os.getenv("HOME") .. "/.local/src/volar/node_modules/typescript/lib/tsserverlibrary.js"
-- -- local filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
local filetypes_with = { "typescript", "javascript", "vue" }

-- local function get_smartass_typescript_server_path(root_dir)
-- 	local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
-- 	local local_tsserverlib = project_root ~= nil
-- 		and lspconfig_util.path.join(project_root, "node_modules", "typescript", "lib", "tsserverlibrary.js")
-- 	local global_tsserverlib = "/lib/node_modules/typescript/lib/tsserverlibrary.js"
-- 	print(global_tsserverlib, local_tsserverlib)
-- 	if local_tsserverlib and lspconfig_util.path.exists(local_tsserverlib) then
-- 		return local_tsserverlib
-- 	else
-- 		return global_tsserverlib
-- 	end
-- end

local function get_typescript_server_path(root_dir)
	local global_ts = os.getenv("HOME") .. "/.config/yarn/global/node_modules/typescript/lib/tsserverlibrary.js"
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
	local found_ts = ""
	local function check_dir(path)
		found_ts = lspconfig_util.path.join(path, "node_modules", "typescript", "lib", "tsserverlibrary.js")
		if lspconfig_util.path.exists(found_ts) then
			return path
		end
	end
	if lspconfig_util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

local function smartass_on_new_config(new_config, new_root_dir)
	new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
end

local settings = {
	volar = {
		-- codeLens = {
		-- 	scriptSetupTools = true,
		-- 	references = true,
		-- 	pugTools = true,
		-- },
		lowPowerMode = false,
		-- formatting = { printWidth = 100 },
		autoCompleteRefs = true,
		takeOverMode = { enabled = false },
		completion = {
			preferredTagNameCase = "pascal",
			preferredAttrNameCase = "kebab",
			autoImportComponent = true,
		},
	},
}

return {
	cmd = { "vue-language-server", "--stdio" },
	root_dir = lspconfig_util.root_pattern("package.json", ".git/"),
	on_new_config = smartass_on_new_config,
	settings = settings,
	filetypes = filetypes_with,
	init_options = {
		languageFeatures = {
			references = true,
			implementation = true,
			definition = true,
			typeDefinition = true,
			callHierarchy = true,
			hover = true,
			rename = true,
			renameFileRefactoring = true,
			signatureHelp = true,
			codeAction = true,
			workspaceSymbol = true,
			completion = {
				defaultTagNameCase = "both",
				defaultAttrNameCase = "kebabCase",
				-- getDocumentNameCasesRequest = true,
				-- getDocumentSelectionRequest = true,
			},
			schemaRequestService = true,
			documentHighlight = true,
			documentLink = true,
			codeLens = true,
			semanticTokens = true,
			diagnostics = true,
		},
		documentFeatures = {
			selectionRange = true,
			foldingRange = true,
			linkedEditingRange = true,
			documentSymbol = true,
			documentColor = true,
		},
	},
}
