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
  local cspell = require("cspell")

  if not status_ok then
    return
  end

  local utils = require("null-ls.utils")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  local spell_config = {
    config = {
      config_file_preferred_name = "cspell.json",
    },
  }

  M.sources = {
    formatting.shfmt,
    formatting.stylua,
    formatting.fish_indent,
    formatting.prettierd,
    formatting.clang_format,
    -- formatting.nixpkgs_fmt,
    -- formatting.gout,
    -- formatting.goimports_reviser,
    -- formatting.golines,

    diagnostics.hadolint,
    diagnostics.fish,

    cspell.diagnostics.with(spell_config),
    cspell.code_actions.with(spell_config),
  }

  if M.enable_eslint() then
    table.insert(M.sources, require("none-ls.formatting.eslint_d"))
    table.insert(M.sources, require("none-ls.diagnostics.eslint_d"))
    table.insert(M.sources, require("none-ls.code_actions.eslint_d"))
  end

  null_ls.setup({
    debug = false,
    root_dir = utils.root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git", "cspell.json"),
    sources = M.sources,
  })
end

return M
