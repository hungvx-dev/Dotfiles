local function js_formatter(bufnr)
  -- if require('conform').get_formatter_info('biome', bufnr).available then
  --   return { 'biome' }
  -- elseif require('conform').get_formatter_info('oxfmt', bufnr).available then
  --   return { 'oxlint', 'oxfmt' }
  -- elseif require('conform').get_formatter_info('prettierd', bufnr).available then
  --   return { 'prettierd', 'eslint_d' }
  -- else
  --   return {}
  -- end

  return { 'oxlint', 'oxfmt' }
end

return {
  opts = {
    default_format_opts = {
      timeout_ms = 2000,
      async = true,
      quiet = false,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      sh = { 'shfmt' },
      fish = { 'fish_indent' },

      cpp = { 'clang_format' },
      c = { 'clang_format' },
      go = { 'goimports', 'gofumpt' },
      lua = { 'stylua' },
      java = { 'google_java_format' },
      -- rust = { "cargo-fmt" },
      graphql = js_formatter,
      javascript = js_formatter,
      typescript = js_formatter,
      javascriptreact = js_formatter,
      typescriptreact = js_formatter,
      vue = js_formatter,
      json = js_formatter,
      jsonc = js_formatter,
      html = js_formatter,
      css = { 'oxfmt', 'prettierd', stop_after_first = true },
      sass = { 'oxfmt', 'prettierd', stop_after_first = true },
      toml = { 'oxfmt', 'prettierd', stop_after_first = true },
      handlebars = { 'oxfmt', 'prettierd', stop_after_first = true },
      markdown = { 'oxfmt', 'prettierd', stop_after_first = true },
      yaml = js_formatter,
    },
  },
}
