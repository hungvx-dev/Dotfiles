local style = require("plugins.configs.ui.lualine.style")
local M = {}

M.init = function()
  vim.g.lualine_laststatus = vim.o.laststatus
  if vim.fn.argc(-1) > 0 then
    vim.o.statusline = " "
  else
    vim.o.laststatus = 0
  end
end

M.setup = function()
  if #vim.api.nvim_list_uis() == 0 then
    return
  end

  require("lualine").setup(style)
end

return M
