local ensure_installed = {
  -- LSP
  'clangd',
  'css-lsp',
  'cssmodules-language-server',
  'docker-compose-language-service',
  'docker-language-server',
  'emmet-language-server',
  'emmylua_ls',
  'gh-actions-language-server',
  'gopls',
  'html-lsp',
  'json-lsp',
  'nil',
  'prisma-language-server',
  'rust-glancer',
  'sqls',
  'tailwindcss-language-server',
  'tsc',
  'vue-language-server',
  'yaml-language-server',

  -- For Formatter
  'stylua', -- For lua
  'shfmt', -- For sh
  'prettierd', -- For js
  'clang-format', -- For c/c++
  'nixpkgs-fmt', -- For nix
  -- "google-java-format", -- For java
  'goimports', -- For go
  'gofumpt', -- For go
  'oxfmt',

  -- For Linter
  'oxlint',
  -- 'typos-lsp',
  -- 'eslint_d', -- For js
  'hadolint', -- For docker
  -- 'biome',
  -- 'selene',
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
