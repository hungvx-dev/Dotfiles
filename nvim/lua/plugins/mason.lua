local ensure_installed = {
  -- LSP
  'vtsls',
  'tsgo',
  'vue-language-server',
  'json-lsp',
  'html-lsp',
  'emmet-language-server',
  'css-lsp',
  'cssmodules-language-server',
  'tailwindcss-language-server',
  'lua-language-server',
  'typescript-language-server',
  'yaml-language-server',
  'clangd',
  'gopls',
  'rust-analyzer',
  'nil',
  'dockerfile-language-server',
  'docker-compose-language-service',
  'postgres-language-server',
  'luau-lsp',
  'prisma-language-server',
  'eslint-lsp', -- For js
  'sqls',
  -- "oxc_language_server",

  -- For Formatter
  'stylua', -- For lua
  'shfmt', -- For sh
  'prettierd', -- For js
  'clang-format', -- For c/c++
  'nixpkgs-fmt', -- For nix
  -- "google-java-format", -- For java
  'goimports', -- For go
  'gofumpt', -- For go
  'yamllint',

  -- For Linter
  'typos-lsp',
  'eslint_d', -- For js
  'hadolint', -- For docker
  'oxlint',
  'oxfmt',
  'biome',
  'selene',
  -- "stylelint",

  -- For Code action
  'gomodifytags', -- For go
  'impl', -- For go
}

return {
  ensure_installed = ensure_installed,
  opts = {
    ui = {
      border = 'rounded',
      icons = {
        package_installed = HVIM.icons.Mason.Installed,
        package_pending = HVIM.icons.Mason.Pending,
        package_uninstalled = HVIM.icons.Mason.Uninstall,
      },
    },
  },
}
