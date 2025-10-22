---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc", "json5" },
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
