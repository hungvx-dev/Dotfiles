local M = {}

function M.setup()
  local lConfigs = require("plugins.configs.lsp.language-configs")
  local status_ok, lspconfig = pcall(require, "lspconfig")
  if not status_ok then
    return
  end
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  )

  local lServers = lConfigs.servers
  local lSetup = lConfigs.setup
  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, lServers[server] or {})

    if lSetup[server] then
      if lSetup[server](server, server_opts) then
        return
      end
    end
    lspconfig[server].setup(server_opts)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(lServers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  require("plugins.configs.lsp.mason-lspconfig").setup(ensure_installed, setup)
  require("plugins.configs.lsp.diagnostic").setup()
  require("plugins.configs.lsp.keymaps")
  require("plugins.configs.lsp.functions").fixConflictTsLanguage()
end

return M
