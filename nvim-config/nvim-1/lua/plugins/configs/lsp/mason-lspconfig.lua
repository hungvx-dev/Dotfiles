local M = {}

function M.setup()
  local servers = require("plugins.configs.lsp.servers")
  local setup = require("plugins.configs.lsp.nvim-lspconfig").setup(servers.opts)
  require("mason-lspconfig").setup({
    ensure_installed = servers.ensure_installed,
    handlers = { setup },
    automatic_installation = true,
  })
  require("plugins.configs.lsp.diagnostic").setup()
  require("plugins.configs.lsp.keymaps")
  -- require("lspconfig.ui.windows").default_options.border = "rounded"
end

return M
