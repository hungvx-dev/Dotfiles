---@type vim.lsp.Config
return {
  cmd = { "luau-lsp", "lsp" },
  filetypes = { "luau" },
  settings = {
    ["luau-lsp"] = {
      sourcemap = {
        enabled = false, -- Disable sourcemap loading
      },
    },
  },
}
