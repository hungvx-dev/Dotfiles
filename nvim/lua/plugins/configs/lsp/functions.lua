local M = {}

function M.lsp_get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

function M.lsp_disable(server, cond)
  local lspUtil = require("lspconfig.util")
  server.document_config.on_new_config = lspUtil.add_hook_before(
    server.document_config.on_new_config,
    function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end
  )
end

function M.get_pkg_path(pkg, path, opts)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  return ret
end

return M
