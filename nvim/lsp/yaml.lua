---@type vim.lsp.Config
return {
	cmd = { "yaml-language-server", "--stdio" },
	single_file_support = true,
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
			schemas = {
				kubernetes = "k8s/**/*.{yaml}",
			},
			redhat = { telemetry = { enabled = false } },
      keyOrdering = false,
      hover = true,
      completion = true,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
    },
  },
}
