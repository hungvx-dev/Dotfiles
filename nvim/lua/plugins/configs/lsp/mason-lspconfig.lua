local M = {}

function M.setup(ensure_installed, setup)
  local status_ok, m_lsp = pcall(require, "mason-lspconfig")
  if not status_ok then
    return
  end

  m_lsp.setup({ ensure_installed = ensure_installed, handlers = { setup }, automatic_installation = true })
end

return M
