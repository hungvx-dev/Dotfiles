local lualine = require("plugins.configs.lualine")

return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = { "mini.icons" },
  init = function()
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = lualine.opts,
}
