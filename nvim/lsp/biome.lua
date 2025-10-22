---@type vim.lsp.Config
return {
  cmd = { "biome", "lsp-proxy" },
  root_markers = { "biome.json", "biome.jsonc" },
  filetypes = {
    "css",
    "graphql",
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  workspace_required = true,
  on_attach = function(client, bufnr)
    if client.name == "vtsls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
}
