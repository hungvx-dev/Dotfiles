local M = {}

M.opts = {
  filetypes = {
    "html",
    "css",
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "lua",
    "scss",
    "conf",
    "fish",
    "yml",
    ".gitconfig",
  },
  user_default_options = {
    mode = "background",
    tailwind = false, -- Enable tailwind colors
  },
}

function M.setup()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    return
  end

  colorizer.setup(M.opts)
end

return M
