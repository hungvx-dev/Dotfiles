---@type vim.lsp.Config
return {
  cmd = { 'emmet-language-server', '--stdio' },
  single_file_support = true,
  filetypes = {
    'html',
    'typescriptreact',
    'css',
    'sass',
    'scss',
    'vue',
    'svg',
    'xml',
  },
  init_options = { provideFormatter = true },
}
