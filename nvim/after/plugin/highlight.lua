vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#292e42" })
vim.api.nvim_set_hl(0, "FloatShadow", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = "NONE" })

vim.api.nvim_set_hl(0, "CleverFDefaultLabel", { fg = "#ff7788", underline = true })
vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#ff1122", underline = false, bold = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#afff5f", underline = false })

local fold_colors = {
  "#24aeee",
  "#f984d4",
  "#86ef84",
  "#b67cff",
  "#fde64d",
  "#fc5f66",
  "#E8E2D9",
  "#4fd1c5",
  "#ff9f49",
  "#a0aacc",
}
for i, color in ipairs(fold_colors) do
  if i == 1 then
    vim.api.nvim_set_hl(0, "FoldLevel_" .. i, { fg = color, bold = true })
  else
    vim.api.nvim_set_hl(0, "FoldLevel_" .. i, { fg = color })
  end
end
vim.wo.foldnestmax = #fold_colors
