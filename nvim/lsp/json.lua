---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc", "json5" },
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
