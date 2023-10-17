local M = {}

local Util = require "utils"

function M.setup(opts)
  -- setup autoformat
  require("lsp.handler.format").setup(opts)
  -- setup formatting and keymaps
  Util.on_attach(function(client, buffer)
    require("lsp.handler.keymaps").on_attach(client, buffer)
  end)

  local register_capability = vim.lsp.handlers["client/registerCapability"]

  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client_id = ctx.client_id
    ---@type lsp.Client
    local client = vim.lsp.get_client_by_id(client_id)
    local buffer = vim.api.nvim_get_current_buf()
    require("lsp.handler.keymaps").on_attach(client, buffer)
    return ret
  end

  -- diagnostics
  require("lsp.config").setup()

  local servers = opts.servers
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    opts.capabilities or {}
  )

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end
    require("lspconfig")[server].setup(server_opts)
  end

  -- get all the servers that are available through mason-lspconfig
  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } }
  end

  if Util.lsp_get_config "volar" and Util.lsp_get_config "tsserver" then
    local is_volar = require("lspconfig.util").root_pattern(
      "vite.config.json",
      "vite.config.jsonc",
      "vite.config.ts",
      "vite.config.js",
      "vue.config.js",
      "vue.config.ts",
      "nuxt.config.ts",
      "nuxt.config.js"
    )
    Util.lsp_disable("tsserver", is_volar)
    Util.lsp_disable("volar", function(root_dir)
      return not is_volar(root_dir)
    end)
  end
end

return M
