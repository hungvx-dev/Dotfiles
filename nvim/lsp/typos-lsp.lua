---@type vim.lsp.Config
return {
  cmd = { "typos-lsp" },
  cmd_env = { RUST_LOG = "error" },
  -- filetypes = { "rust", "go", "typescript", "javascript", "markdown", "text" },
  root_markers = { "typos.toml", "_typos.toml", ".typos.toml", "pyproject.toml", "Cargo.toml" },
  single_file_support = true,
  init_options = {
    -- config = "~/code/typos-lsp/crates/typos-lsp/tests/typos.toml",
    diagnosticSeverity = "Info",
  },
}
