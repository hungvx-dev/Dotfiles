local M = {}

function M.get_pkg_path(pkg, path)
  local mason_registry = require("mason-registry")
  return mason_registry.get_package(pkg):get_install_path() .. path
end

-- location = "/Users/hungvx.dev/.local/share/nvim/mason/packages/vue-language-server//node_modules/@vue/language-server",

return M
