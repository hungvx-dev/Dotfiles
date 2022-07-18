-- require("plugins/lsp/bash")
-- -- require("plugins/lsp/lua")
-- require("plugins/lsp/yamlls")
-- require("plugins/lsp/json")
-- require("plugins/lsp/javascript")
-- require("plugins/lsp/css")
-- require("plugins/lsp/javascript")
-- require("plugins/lsp/other")
-- require("plugins/lsp/vuejs-vls")

require "plugins.lsp.cmp"
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "plugins.lsp.lsp-signature"
require "plugins.lsp.settings.vuejs"
require "plugins.lsp.lsp-installer"
require("plugins.lsp.handlers").setup()
require "plugins.lsp.null-ls"
