local hybridMode = false
local volar_init_options = {
  hostInfo = "neovim",
  vue = {
    hybridMode = hybridMode,
  },
  typescript = {
    tsdk = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/typescript/lib"),
  },
  preferences = {
    disableSuggestions = false,
  },
  languageFeatures = {
    implementation = true,
    references = true,
    definition = true,
    typeDefinition = true,
    callHierarchy = true,
    hover = true,
    rename = true,
    renameFileRefactoring = true,
    signatureHelp = true,
    codeAction = true,
    workspaceSymbol = true,
    diagnostics = true,
    semanticTokens = true,
    completion = {
      defaultTagNameCase = "both",
      defaultAttrNameCase = "kebabCase",
      getDocumentNameCasesRequest = false,
      getDocumentSelectionRequest = false,
    },
  },
}

---@type vim.lsp.Config
return {
  cmd = { "vue-language-server", "--stdio" },
  -- filetypes = { "vue" },
  filetypes = hybridMode and { "vue" } or { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "html" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", "vite.config.ts", "vite.config.js" },
  init_options = volar_init_options,
  settings = {
    volar = {
      codeLens = {
        references = true,
        pugTools = true,
        scriptSetupTools = true,
      },
    },
    typescript = {
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        parameterTypes = {
          enabled = true,
          suppressWhenArgumentMatchesName = true,
        },
        variableTypes = {
          enabled = true,
        },
      },
    },
  },
  -- on_attach = function(_) end,
}
