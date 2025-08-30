---@type vim.lsp.Config
return {
  cmd = { "nil", "--stdio" },
  filetypes = { "nix" },
  root_markers = { "flake.nix" },
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
