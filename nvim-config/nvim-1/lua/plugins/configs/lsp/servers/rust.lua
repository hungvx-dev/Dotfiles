return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
      },
      check = {
        command = "clippy",
      },
      -- checkOnSave = {
      --   command = "clippy",
      -- },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
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
  on_attach = function(client, bufnr)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
}
