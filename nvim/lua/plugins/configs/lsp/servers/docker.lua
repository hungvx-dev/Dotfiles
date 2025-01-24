return {
  root_dir = require("lspconfig").util.root_pattern(
    "Dockerfile",
    "docker-compose.yml",
    "compose.yml",
    "docker-compose.yaml",
    "compose.yaml"
  ),
  filetypes = { "dockerfile" },
}
