local style = require("plugins.configs.ui.lualine.style")
local M = {}

M.setup = function()
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  lualine.setup(style)
end

return M
