---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'vscode-css-language-server'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
  end,
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { 'package.json', '.git' },
  init_options = { provideFormatter = true },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },
  on_attach = function(client)
    if vim.bo.filetype == 'scss' then
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
    end
  end,
}
