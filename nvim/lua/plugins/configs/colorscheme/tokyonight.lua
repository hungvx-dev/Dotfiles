local present, tokyonight = pcall(require, "tokyonight")
if not present then
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Color scheme                                       │
-- ╰──────────────────────────────────────────────────────────╯
tokyonight.setup({
  style = "night",
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = {},
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = {},
  hide_inactive_statusline = true,
  day_brightness = 0.15,
  on_colors = function(colors)
    -- Support transparent
    colors.none = "NONE"
    colors.bg = "NONE"
    colors.bg_dark = colors.none
    colors.bg_float = colors.none
    colors.bg_sidebar = colors.none
    colors.bg_statusline = colors.none
    colors.black = colors.none
    colors.bg_popup = "#1a1b26"
    colors.comment = "#b9b9d9"
    colors.fg_gutter = "#394b70"

    -- No change
    -- colors.bg_highlight = "#292e42"
    -- colors.bg_visual = "#283457"
    colors.rainbow = { "#74a2ff", "#eeab00", "#8fd300", "#00bd9c", "#bd98ff", "#a86dff" }

    colors.bg_search = "#0057c4"
    colors.blue = "#74a2ff"
    colors.blue0 = "#0057c4"
    colors.blue1 = "#00c4e0"
    colors.blue2 = "#00b9d7"
    colors.blue5 = "#89ddff"
    colors.blue6 = "#8cfffe"
    colors.blue7 = "#004b92"
    colors.border = "#131525"
    colors.border_highlight = "#00a2bb"
    colors.cyan = "#7dcfff"
    colors.dark3 = "#455a9d"
    colors.dark5 = "#6677c6"
    colors.diff = {
      add = "#20303b",
      change = "#1f2231",
      delete = "#37222c",
      text = "#394b70",
    }
    colors.error = "#fb0000"
    colors.fg = "#bdcaff"
    colors.fg_dark = "#9daff8"
    colors.fg_float = "#bdcaff"
    colors.fg_sidebar = "#9daff8"
    colors.git = {
      add = "#449dab",
      change = "#6183bb",
      delete = "#914c54",
      ignore = "#545c7e",
    }
    colors.green = "#8fd300"
    colors.green1 = "#00e1cb"
    colors.green2 = "#00a8ba"
    colors.hint = "#00bd9c"
    colors.info = "#00b9d7"
    colors.magenta = "#bd98ff"
    colors.magenta2 = "#ff007c"
    colors.orange = "#ff9e64"
    colors.purple = "#a86dff"
    colors.red = "#ff708c"
    colors.red1 = "#fb0000"
    colors.teal = "#00bd9c"
    colors.terminal_black = "#334685"
    colors.todo = "#74a2ff"
    colors.warning = "#eeab00"
    colors.yellow = "#eeab00"
  end,
  on_highlights = function(hl, colors)
    hl.TelescopeTitle = { fg = "#FFA630" }
    hl.CursorLineNr = { fg = "#EFFF00" }
    hl.CursorLine = { bg = colors.none }
    hl.Cursor = { bg = colors.blue1 }
    hl.PmenuSbar = { bg = colors.none }
    hl.GitSignsCurrentLineBlame = { fg = "#5e647a" }
  end,
})
