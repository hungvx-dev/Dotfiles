local M = {}

function M.setup_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local has_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
  local has_blink, blink = pcall(require, "blink.cmp")
  return vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_lsp_file and lsp_file.default_capabilities() or {},
    has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    has_blink and blink.get_lsp_capabilities() or {}
  )
end

function M.setup(opts)
  local lspconfig = require("lspconfig")
  local capabilities = M.setup_capabilities()

  local function setup(server)
    local s_opt = opts[server] or {}
    local opt = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, s_opt)

    if s_opt.enabled == false then
      return
    end

    lspconfig[server].setup(opt)
  end

  return setup
end

return M
