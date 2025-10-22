local vue_language_server_path = vim.fn.expand("$MASON/packages") .. "/vue-language-server" .. "/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
  enableForWorkspaceTypeScriptVersions = true,
}

local shared_config = {
  updateImportsOnFileMove = { enabled = "always" },
  suggest = { completeFunctionCalls = true },
  tsserver = {
    maxTsServerMemory = 8192,
  },
  inlayHints = {
    parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
  },
}

---@type vim.lsp.Config
return {
  cmd = { "vtsls", "--stdio" },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
  filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },
  single_file_support = true,
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
    typescript = shared_config,
    javascript = shared_config,
  },
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == "vue" then
      client.server_capabilities.semanticTokensProvider.full = false
    else
      client.server_capabilities.semanticTokensProvider.full = true
    end
  end,
}
