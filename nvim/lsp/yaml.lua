--- ```lua
--- vim.lsp.config('yamlls', {
---   ...
---   settings = {
---     yaml = {
---       ... -- other settings. note this overrides the lspconfig defaults.
---       schemas = {
---         ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
---         ["../path/relative/to/file.yml"] = "/.github/workflows/*",
---         ["/path/from/root/of/project"] = "/.github/workflows/*",
---       },
---     },
---   }
--- })
--- ```
---
---
--- ```lua
--- vim.lsp.config('yamlls', {
---   ...
---   settings = {
---     yaml = {
---       ... -- other settings. note this overrides the lspconfig defaults.
---       schemas = {
---         ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] = "/*.k8s.yaml",
---         ... -- other schemas
---       },
---     },
---   }
--- })
--- ```

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'yaml-language-server'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
  end,
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  root_markers = { '.git' },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = { format = { enable = true } },
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
