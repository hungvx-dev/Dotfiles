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
  local status_ok, null_ls = pcall(require, "null-ls")

  if not status_ok then
    return
  end

  local utils = require("null-ls.utils")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions
  -- local completion = null_ls.builtins.completion

  local spell = { config = { config_file_preferred_name = "cSpell.json" } }

  M.sources = {
    formatting.shfmt,
    formatting.stylua,
    formatting.fish_indent,
    formatting.prettierd,

    diagnostics.hadolint,
    diagnostics.fish,
    diagnostics.cspell.with(spell),

    code_actions.cspell.with(spell),
    -- completion.spell,
  }

  if M.enable_eslint() then
    table.insert(M.sources, formatting.eslint_d)
    table.insert(M.sources, diagnostics.eslint_d)
    table.insert(M.sources, code_actions.eslint_d)
  end

  null_ls.setup({
    debug = false,
    root_dir = utils.root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
    sources = M.sources,
  })
end

return M
