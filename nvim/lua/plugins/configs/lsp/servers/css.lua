return {
  css = {
    lint = {
      unknownAtRules = "ignore",
    },
  },
  scss = {
    lint = {
      unknownAtRules = "ignore",
    },
  },
  on_attach = function(client)
    if vim.bo.filetype == "scss" then
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
    end
  end,
}
