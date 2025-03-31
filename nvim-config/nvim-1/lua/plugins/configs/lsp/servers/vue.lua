return {
  enabled = true,
  root_dir = require("lspconfig.util").root_pattern(
    "vue.config.js",
    "vue.config.ts",
    "nuxt.config.js",
    "nuxt.config.ts",
    "vite.config.ts",
    "vite.config.js"
  ),
  filetypes = { "vue" },
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
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
