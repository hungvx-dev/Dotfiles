local M = {}

function M.setup()
  local servers = require("plugins.configs.lsp.servers.init")
  local setup = require("plugins.configs.lsp.nvim-lspconfig").setup(servers.opts)
  require("plugins.configs.lsp.mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers.ensure_installed,
    handlers = { setup },
    automatic_installation = true,
  })
  require("plugins.configs.lsp.diagnostic").setup()
  require("plugins.configs.lsp.keymaps")
end

return M
