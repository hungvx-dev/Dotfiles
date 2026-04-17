if vim.g.colors_name then
  vim.cmd("hi clear")
end
local feiyu = require("themes.eryx")

vim.g.colors_name = HVIM.colorscheme
feiyu.setup(HVIM.plugins, HVIM.highlight)
