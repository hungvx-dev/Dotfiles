local nls = require "null-ls"
local utils = require "null-ls.utils"

local is_in_current_project = function()
  local file = vim.fn.expand "%:p:h"
  local pwd = vim.fn.getcwd()

  return vim.fn.stridx(file, pwd) >= 0
end

local is_exist = function(file)
  return vim.fn.filereadable(file) > 0
end

local enable_eslint = function()
  return is_exist "node_modules/.bin/eslint" and is_in_current_project()
end

-- local enable_prettier = function()
--   return is_exist "node_modules/.bin/prettier" and is_in_current_project()
-- end

local sources = {
  -- nls.builtins.diagnostics.standardjs,
  -- nls.builtins.formatting.codespell,
  -- nls.builtins.diagnostics.codespell,
  -- nls.builtins.formatting.fish_indent,
  -- nls.builtins.diagnostics.fish,
  nls.builtins.formatting.shfmt,
  nls.builtins.formatting.stylua,
  nls.builtins.formatting.prettierd,
  require "typescript.extensions.null-ls.code-actions",
}

if enable_eslint() then
  table.insert(sources, nls.builtins.diagnostics.eslint_d)
  table.insert(sources, nls.builtins.code_actions.eslint_d)
  table.insert(sources, nls.builtins.formatting.eslint_d)
end

nls.setup {
  root_dir = utils.root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  sources = sources,
  debug = false,
}
