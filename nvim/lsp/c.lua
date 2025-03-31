---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "--pch-storage=memory",
    "--limit-results=50",
  },
  filetypes = { "c", "cpp", "proto" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clang", "Makefile", "configure.ac", "configure.in", "config.h.in", "meson.build", "meson_options.txt", "build.ninja" },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
}
