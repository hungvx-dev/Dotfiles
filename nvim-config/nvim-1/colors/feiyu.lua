if vim.g.colors_name then
  vim.cmd("hi clear")
end
local feiyu = require("themes.feiyu")

vim.g.colors_name = "feiyu"
feiyu.setup(HVIM.plugins, HVIM.highlight)
