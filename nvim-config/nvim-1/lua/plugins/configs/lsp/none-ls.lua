local M = {}

function M.is_in_current_project()
  local file = vim.fn.expand("%:p:h")
  local pwd = vim.fn.getcwd()

  return vim.fn.stridx(file, pwd) >= 0
end

function M.is_exist(file)
  return vim.fn.filereadable(file) > 0
end

function M.enable_eslint()
  return M.is_exist("node_modules/.bin/eslint") and M.is_in_current_project()
end

function M.setup()
  local null_ls = require("null-ls")
  local utils = require("null-ls.utils")

  local cspell = require("cspell")
  -- local code_actions = null_ls.builtins.code_actions

  local spell_config = {
    config = {
      config_file_preferred_name = "cspell.json",
    },
  }

  M.sources = {
    -- code_actions.gomodifytags,
    -- code_actions.impl,

    cspell.diagnostics.with(spell_config),
    cspell.code_actions.with(spell_config),
  }

  if M.enable_eslint() then
    table.insert(M.sources, require("none-ls.code_actions.eslint_d"))
  end

  null_ls.setup({
    debug = false,
    root_dir = utils.root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git", "cspell.json"),
    sources = M.sources,
  })
end

return M
