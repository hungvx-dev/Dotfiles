local M = {}

M.opts = {
  signs = HVIM.signs,
  diagnostic = {
    underline = true,
    update_in_insert = false,
    -- virtual_text = { spacing = 4, prefix = "●" },
    -- virtual_text = false,
    severity_sort = true,
    float = {
      focusable = true,
      focus = false,
      border = "rounded",
      source = true,
    },
  },
}

function M.setup()
  for name, icon in pairs(M.opts.signs) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  vim.diagnostic.config(M.opts.diagnostic)
end

return M
