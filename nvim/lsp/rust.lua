---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  root_markers = { "Cargo.toml", "Cargo.lock", "build.rs" },
  filetypes = { "rust", "toml.Cargo" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
        target = "aarch64-apple-darwin",
      },
      diagnostics = {
        enable = true,
        styleLints = {
          enable = true,
        },
        experimental = {
          enable = true,
        },
      },
      checkOnSave = false,
      check = {
        command = "clippy",
        features = "all",
        allTargets = true,
      },
      -- checkOnSave = true,
      -- checkOnSave = {
      --   command = "clippy",
      -- },
      inlayHints = {
        enable = true,
        parameterHints = { enable = true },
        typeHints = { enable = true },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
      files = {
        excludeDirs = {
          ".direnv",
          ".git",
          ".github",
          ".gitlab",
          "bin",
          "node_modules",
          "target",
          "venv",
          ".venv",
        },
      },
    },
  },
}
