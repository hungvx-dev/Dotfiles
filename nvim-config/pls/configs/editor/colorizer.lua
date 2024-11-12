local M = {}

M.opts = {
  filetypes = {
    "html",
    "css",
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "vue",
    "lua",
    "scss",
    "conf",
    "fish",
    "yml",
    "toml",
    ".gitconfig",
  },
  user_default_options = {
    mode = "inline",
    tailwind = true, -- Enable tailwind colors
  },
}

return M
