---@type vim.lsp.Config
return {
  cmd = { "postgrestools", "lsp-proxy" },
  filetypes = { "sql" },
  single_file_support = true,
  settings = {
    postgres_lsp = {
      --   connection = {
      --     host = "localhost",
      --     port = 5432,
      --     user = "your_username",
      --     password = "your_password",
      --     database = "your_database",
      --   },
    },
  },
}
