local M = {}

function M.lsp_get_config(server)
  local configs = require "lspconfig.configs"
  return rawget(configs, server)
end

function M.lsp_disable(server, cond)
  local lspUtil = require "lspconfig.util"
  server.document_config.on_new_config = lspUtil.add_hook_before(server.document_config.on_new_config,
    function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end)
end

function M.fixConflictTsLanguage()
  local lspUtil = require "lspconfig.util"
  local volar = M.lsp_get_config("volar")
  local tsserver = M.lsp_get_config("tsserver")
  if volar and tsserver then
    local is_volar = lspUtil.root_pattern(
      "vite.config.json",
      "vite.config.jsonc",
      "vite.config.ts",
      "vite.config.js",
      "vue.config.js",
      "vue.config.ts",
      "nuxt.config.ts",
      "nuxt.config.js"
    )

    tsserver.document_config.on_new_config = lspUtil.add_hook_before(tsserver.document_config.on_new_config,
      function(config, root_dir)
        if is_volar(root_dir, config) then
          config.enabled = false
        end
      end)

    volar.document_config.on_new_config = lspUtil.add_hook_before(volar.document_config.on_new_config,
      function(config, root_dir)
        if not is_volar(root_dir, config) then
          config.enabled = false
        end
      end)
  end
end

return M
