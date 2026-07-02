return {
  opts = {
    lsp = {
      'c',
      'css',
      'cssmodules',
      'docker-compose',
      'docker',
      'prisma',
      'emmet',
      'go',
      'html',
      'json',
      'lua',
      'sqls',
      -- "luau",
      'nix',
      -- "postgresql",
      'rust',
      'tailwindcss',
      "vtsls",
      -- 'tsgo',
      -- "typescript",
      'vue',
      'yaml',
      -- "biome",
      'eslint',
      'oxlint',
      -- "oxfmt",
      -- "typos-lsp",
      -- "oxc"
    },
    diagnostic = {
      update_in_insert = false,
      severity_sort = true,
      -- underline = true,
      -- virtual_lines = { current_line = true },
      float = {
        focusable = true,
        focus = false,
        border = 'rounded',
        source = 'if_many',
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = HVIM.signs.Error,
          [vim.diagnostic.severity.WARN] = HVIM.signs.Warn,
          [vim.diagnostic.severity.INFO] = HVIM.signs.Info,
          [vim.diagnostic.severity.HINT] = HVIM.signs.Hint,
        },
      },
      -- virtual_text = {
      --   source = "if_many",
      --   spacing = 2,
      --   format = function(diagnostic)
      --     local diagnostic_message = {
      --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
      --       [vim.diagnostic.severity.WARN] = diagnostic.message,
      --       [vim.diagnostic.severity.INFO] = diagnostic.message,
      --       [vim.diagnostic.severity.HINT] = diagnostic.message,
      --     }
      --     return diagnostic_message[diagnostic.severity]
      --   end,
      -- },
    },
  },
}
