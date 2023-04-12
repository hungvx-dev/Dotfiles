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

-- local enable_standardjs = function()
--   return is_exist "node_modules/.bin/standard" and is_in_current_project()
-- end

local enable_prettier = function()
  return is_exist "node_modules/.bin/prettier" and is_in_current_project()
end

local sources = {}

if enable_eslint() then
  table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
  table.insert(sources, null_ls.builtins.code_actions.eslint_d)
  table.insert(sources, null_ls.builtins.formatting.eslint_d)
end

-- if enable_standardjs() then
--   table.insert(sources, null_ls.builtins.diagnostics.standardjs)
--   table.insert(sources, null_ls.builtins.formatting.standardjs)
-- end

if enable_prettier() then
  table.insert(sources, null_ls.builtins.formatting.prettierd)
end

local diagnostics_formats = {
  -- Diagnostic
  -- null_ls.builtins.diagnostics.staticcheck,

  -- Format
  -- null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.prettierd.with {
    filetypes = { "yaml" },
  },
  null_ls.builtins.formatting.prettierd.with {
    filetypes = {
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
    },
  },
  null_ls.builtins.formatting.prettierd.with {
    filetypes = {
      "markdown",
      "markdown.mdx",
    },
    extra_args = { "--prose-wrap", "always" },
  },
  require "typescript.extensions.null-ls.code-actions",
}

for i = 0, #diagnostics_formats do
  if is_in_current_project() then
    table.insert(sources, diagnostics_formats[i])
  end
end

null_ls.setup {
  root_dir = utils.root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
  sources = sources,
  debug = false,
}
