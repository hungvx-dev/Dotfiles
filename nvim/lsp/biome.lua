---@type vim.lsp.Config
return {
  cmd = { "biome", "lsp-proxy" },
  root_markers = { "biome.json", "biome.jsonc" },
  filetypes = {
    "css",
    "graphql",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescriptreact",
    "vue",
  },
  workspace_required = true,
  on_attach = function(client)
    if client.name == "vtsls" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
}

-- Treesitter
--   - @variable.lua links to @variable   priority: 100   language: lua
--   - @property.lua links to @property   priority: 100   language: lua
--
-- Semantic Tokens
--   - @lsp.type.property.lua links to @property   priority: 125

-- Treesitter
--   - @variable.lua links to @variable   priority: 100   language: lua
--   - @property.lua links to @property   priority: 100   language: lua
--   - @function.lua links to Function   priority: 100   language: lua
--
-- Semantic Tokens
--   - @lsp.type.property.lua links to @property   priority: 125
--
--
