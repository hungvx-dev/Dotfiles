local M = {}
-- signs = {
--   active = true,
--   values = {
--     { name = "DiagnosticSignError", text = hvim.icons.Diagnostics.Error },
--     { name = "DiagnosticSignWarn", text = hvim.icons.Diagnostics.Warning },
--     { name = "DiagnosticSignHint", text = hvim.icons.Diagnostics.Hint },
--     { name = "DiagnosticSignInfo", text = hvim.icons.Diagnostics.Information },
--   },
-- },
local opts = {
  diagnostics = {
    underline = true,
    update_in_insert = false,
    -- virtual_text = { spacing = 4, prefix = "●" },
    virtual_text = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
  },
}

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
function M.setup()
  local signs = {
    Error = hvim.icons.Diagnostics.Error,
    Warn = hvim.icons.Diagnostics.Warning,
    Hint = hvim.icons.Diagnostics.Hint,
    Info = hvim.icons.Diagnostics.Information,
  }
  -- diagnostics
  for name, icon in pairs(signs) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  vim.diagnostic.config(opts.diagnostics)

  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.float)
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.float)
end

return M
