local null_ls = require "null-ls"
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
  -- null_ls.builtins.diagnostics.standardjs,
  -- null_ls.builtins.formatting.codespell,
  -- null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.eslint_d,

  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.code_actions.eslint_d,
  require "typescript.extensions.null-ls.code-actions",
}

-- if enable_eslint() then
-- end

null_ls.setup {
  root_dir = utils.root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  sources = sources,
  debug = false,
}
