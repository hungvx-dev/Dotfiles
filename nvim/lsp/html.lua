---@type vim.lsp.Config
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "tmpl", "gotmpl", "template" },
  root_markers = { "package.json" },
  single_file_support = true,
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
  end,
}
