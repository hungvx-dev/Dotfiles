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
    -- colors.bg = "#1a1b26"
    colors.bg_dark = colors.bg
    colors.bg_float = colors.bg
    colors.bg_sidebar = colors.bg
    colors.bg_statusline = colors.bg
    colors.black = colors.bg

    colors.bg = "NONE"
    -- colors.bg_dark = colors.none
    -- colors.bg_float = colors.none
    -- colors.bg_sidebar = colors.none
    -- colors.bg_statusline = colors.none
    -- colors.black = colors.none

    colors.bg_popup = "#1a1b26"
    -- colors.comment = "#3d59a1"
  end,
  on_highlights = function(hl)
    local prompt = "#FFA630"

    hl.CursorLineNr = { fg = "#EFFF00" }
    hl.TelescopeTitle = { fg = prompt }
  end,
}
