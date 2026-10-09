---@type vim.lsp.Config
return {
  cmd = { 'prisma-language-server', '--stdio' },
  filetypes = { 'prisma' },
  settings = {
    prisma = {
      prismaFmtBinPath = '',
      schemaFolder = 'prisma',
    },
  },
  root_markers = { '.git', 'package.json', 'prisma.config.ts' },
}
