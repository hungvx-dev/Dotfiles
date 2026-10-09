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
}
