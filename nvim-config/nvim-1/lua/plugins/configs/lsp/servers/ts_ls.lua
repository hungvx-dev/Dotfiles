local lsp_fns = require("plugins.configs.lsp.functions")

return {
  enabled = false,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = lsp_fns.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    completions = {
      completeFunctionCalls = true,
    },
  },
}
