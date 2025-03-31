---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  root_markers = { "Cargo.toml", "Cargo.lock", "build.rs" },
  filetypes = { "rust", "toml.Cargo" },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
        features = "all",
        allTargets = true,
      },
      cargo = {
        features = "all",
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
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
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
      inlayHints = {
        enable = true,
        parameterHints = { enable = true },
        typeHints = { enable = true },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
      },
      imports = {
        group = {
          enable = false,
        },
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      completion = {
        postfix = {
          enable = true,
        },
        -- snippets = {
        -- 	custom = "None",
        -- },
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
  capabilities = {
    experimental = {
      serverStatusNotification = true,
    },
  },
}
