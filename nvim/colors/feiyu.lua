if vim.g.colors_name then
  vim.cmd("hi clear")
end
local hl = vim.api.nvim_set_hl
local feiyu = require("themes.feiyu")

-- -- # Plugins
-- hl(0, "CleverFDefaultLabel", { fg = "#ff7788", underline = true })
-- hl(0, "EyelinerPrimary", { fg = "#ff1122", underline = false, bold = true })
-- hl(0, "EyelinerSecondary", { fg = "#afff5f", underline = false })
--
-- hl(0, "NeoTreeCursorLine", { bg = colors.bg, underline = true, sp = colors.cyan })
-- hl(0, "NeoTreeWinSeparator", { fg = colors.none })
-- hl(0, "NeoTreeDimText", { fg = colors.cyan })
-- --
-- hl(0, "GitSignsCurrentLineBlame", { bg = colors.blue0 })

vim.g.colors_name = "feiyu"

for group, properties in pairs(feiyu.highlights) do
  if type(properties) == "string" then
    hl(0, group, { link = properties })
  elseif type(properties) == "table" then
    hl(0, group, properties)
  end
end
