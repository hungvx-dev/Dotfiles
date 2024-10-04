local M = {}

M.list = {
  cssls = "css",
  lua_ls = "lua",
  jsonls = "json",
  tailwindcss = "tailwind",
  volar = "vue",
  vtsls = "typescript",
  yamlls = "yaml",
  bashls = "bash",
  dockerls = "docker",
  docker_compose_language_service = "docker-compose",
  emmet_ls = "html",
  ts_ls = "ts_ls",
  -- textlsp = "org",
}

M.opts = {}
M.ensure_installed = {}

for server, lang in pairs(M.list) do
  M.ensure_installed[#M.ensure_installed + 1] = server
  local has_ok, config = pcall(require, "plugins.configs.lsp.servers." .. lang)
  M.opts[server] = has_ok and config or {}
end

return M
