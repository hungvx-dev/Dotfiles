---@type vim.lsp.Config
return {
  cmd = { "biome", "lsp-proxy" },
  root_markers = { "biome.json", "biome.jsonc" },
  filetypes = { "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" },
  workspace_required = true,
  on_attach = function(client, bufnr)
    if client.name == "vtsls" then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
}
