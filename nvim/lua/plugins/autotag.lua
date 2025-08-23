return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "html", "typescriptreact", "vue", "typescript.tsx" },
  opts = {
    opts = {
      enable_close = true,
      enable_rename = false,
      enable_close_on_slash = true,
    },
  },
}
