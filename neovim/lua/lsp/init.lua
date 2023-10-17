local M = {}

local Util = require "utils"

require("lsp.handler").setup()
require("lsp.config").setup()

function M.setup(opts)
  local servers = opts.servers

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local lsp = require "lspconfig"

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

    lsp[server].setup(server_opts)
  end

  -- temp fix for lspconfig rename
  -- https://github.com/neovim/nvim-lspconfig/pull/2439
  local mappings = require "mason-lspconfig.mappings.server"
  if not mappings.lspconfig_to_package.lua_ls then
    mappings.lspconfig_to_package.lua_ls = "lua-language-server"
    mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
  end

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
