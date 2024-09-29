local M = {}

M.opts = {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  disable_in_macro = false,
}

M.setup = function()
  local autopairs = require("nvim-autopairs")
  autopairs.setup(M.opts)
end

return M
