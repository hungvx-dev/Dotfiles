return {
  root_dir = require("lspconfig").util.root_pattern("flake.nix"),
  filetypes = { "nix"},
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
}
