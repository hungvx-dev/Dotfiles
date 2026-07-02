---@type vim.lsp.Config
return {
  cmd = { 'cssmodules-language-server' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
  },
  root_markers = { 'package.json' },
}
