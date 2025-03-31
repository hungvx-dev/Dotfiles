return {
  cmd = { "vue-language-server" },
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
  -- on_attach = function(client)
  --   client.server_capabilities.documentFormattingProvider = false
  --   client.server_capabilities.documentRangeFormattingProvider = false
  -- end,
}
