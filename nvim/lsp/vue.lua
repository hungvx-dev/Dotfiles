---@type vim.lsp.Config
return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", "vite.config.ts", "vite.config.js" },
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
  settings = {
    volar = {
      codeLens = {
        references = true,
        pugTools = true,
        scriptSetupTools = true,
      },
    },
  },
  on_attach = function(_) end,
}
