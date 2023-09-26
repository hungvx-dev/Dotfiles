local present, tokyonight = pcall(require, "tokyonight")
if not present then
  return
end
-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Color scheme                                       │
-- ╰──────────────────────────────────────────────────────────╯
tokyonight.setup {
  style = "night",
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = "NONE",
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = {},
  hide_inactive_statusline = true,
  dim_inactive = false,
  lualine_bold = false,
  on_colors = function(colors)
    colors.bg = "NONE"
    colors.bg_dark = colors.bg
    colors.bg_float = colors.bg
    colors.bg_sidebar = colors.bg
    colors.bg_statusline = colors.bg
    colors.black = colors.bg

    colors.bg_popup = "#1a1b26"
    colors.comment = "#a9b1d6"
    colors.fg_gutter = "#394b70"
    -- colors.megenta = "#bb4af7"
    -- colors.fg = "#ffffff"
    -- colors.fg_float = "#ffffff"
    -- colors.fg_sidebar = "#ffffff"
  end,
  on_highlights = function(hl)
    hl.TelescopeTitle = { fg = "#FFA630" }
    hl.CursorLineNr = { fg = "#EFFF00" }
    hl.CursorLine = { bg = "NONE" }
    -- hl.CursorColumn
  end,
}
