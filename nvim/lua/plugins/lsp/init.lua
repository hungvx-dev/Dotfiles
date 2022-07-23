require "plugins.lsp.cmp"
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "plugins.lsp.lsp-signature"
require "plugins.lsp.lsp-installer"
require "plugins.lsp.settings.vuejs"
require("plugins.lsp.handlers").setup()
require "plugins.lsp.null-ls"
