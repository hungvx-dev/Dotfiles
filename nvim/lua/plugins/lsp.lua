return {
  opts = {
    lsp = {
      'clangd',
      'cssls',
      'cssmodules_ls',
      -- 'docker_language_server',
      'dockerls',
      'docker_compose_language_service',
      'emmet_language_server',
      'emmylua_ls',
      'gh_actions_ls',
      'gopls',
      'html',
      'jsonls',
      'nil_ls',
      -- "oxfmt",
      'oxlint',
      'prismals',
      'rust_glancer',
      'sqls',
      'tailwindcss',
      -- 'tsc',
      "vtsls",
      'vue',
      'yaml',
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
