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

M.setup = function(_, opts)
  local autopairs = require("nvim-autopairs")
  autopairs.setup(opts)

  -- make autopairs and completion work together
  local ok, cmp = pcall(require, "cmp")
  if ok then
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return M
