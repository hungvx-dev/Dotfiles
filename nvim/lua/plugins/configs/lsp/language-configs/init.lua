local M = {}

M.langs = {
  "cssls",
  "jsonls",
  "tailwindcss",
  -- "tsserver",
  "volar",
  "vtsls",
  "yamlls",
}

M.servers = {
  bashls = {},
  dockerls = {},
  docker_compose_language_service = {},
  emmet_ls = {},
}

for _, lang in ipairs(M.langs) do
  M.servers[lang] = require("plugins.configs.lsp.language-configs." .. lang)
end

M.setup = {
  tsserver = function(_)
    -- require("typescript").setup({ server = opts })
    return true
  end,
}

return M
