local lsp_fns = require("plugins.configs.lsp.functions")

return {
  enabled = false,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = lsp_fns.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
        languages = { "vue" },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
  settings = {
    typescript = {
      format = {
        indentSize = vim.o.shiftwidth,
        convertTabsToSpaces = vim.o.expandtab,
        tabSize = vim.o.tabstop,
      },
    },
    javascript = {
      format = {
        indentSize = vim.o.shiftwidth,
        convertTabsToSpaces = vim.o.expandtab,
        tabSize = vim.o.tabstop,
      },
    },
    completions = {
      completeFunctionCalls = true,
    },
  },
}
