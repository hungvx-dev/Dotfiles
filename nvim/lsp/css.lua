---@type vim.lsp.Config
return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json" },
  settings = {
    css = { validate = true, lint = {
      unknownAtRules = "ignore",
    } },
    scss = { validate = true, lint = {
      unknownAtRules = "ignore",
    } },
    less = { validate = true },
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    if vim.bo.filetype == "scss" then
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
    end
  end,
}
