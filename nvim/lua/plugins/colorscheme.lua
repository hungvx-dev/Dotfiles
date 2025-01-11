return {
  "folke/tokyonight.nvim",
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
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
    cache = true,
    sidebars = {},
    hide_inactive_statusline = true,
    on_colors = function(colors)
      -- Support transparent
      colors.none = "NONE"
      colors.bg = colors.none
      colors.bg_dark = colors.none
      colors.bg_float = colors.none
      colors.bg_sidebar = colors.none
      colors.bg_statusline = colors.none
      colors.black = colors.none
      colors.bg_popup = "#000000"
      colors.comment = "#a0aacc"
      -- colors.fg_gutter = "#A9A9A9"

      colors.bg_search = "#4A68A0"
      colors.blue = "#74a2ff"
      colors.blue0 = "#3d59a1"
      colors.blue1 = "#00c4e0"
      colors.blue6 = "#8cfffe"
      colors.blue7 = "#004b92"
      colors.dark3 = "#455a9d"
      colors.dark5 = "#6677c6"
      colors.error = "#fb0000"
      colors.fg = "#bdcaff"
      colors.fg_dark = "#9daff8"
      colors.fg_float = "#bdcaff"
      colors.fg_sidebar = "#9daff8"
      colors.green = "#8fd300"
      colors.green1 = "#00e1cb"
      colors.green2 = "#00a8ba"
      colors.purple = "#a86dff"
      colors.red = "#fc5f66"
      colors.red1 = "#fb0000"
      colors.terminal_black = "#334685"
      colors.warning = "#eeab00"
      colors.yellow = "#EFFF00"
    end,
    on_highlights = function(hl, colors)
      -- hl.WinSeparator = { fg = colors.fg_dark }
      -- hl.NeoTreeTabSeparatorActive = { fg = colors.blue7 }
      -- hl.NeoTreeWinSeparator = { fg = colors.blue7 }
      hl.Cursor = { bg = colors.blue1 }
      hl.CursorLine = { bg = colors.none, underline = true, sp = colors.blue1 }
      hl.PmenuSbar = { bg = colors.none }
      hl.CursorLineNr = { fg = colors.yellow }
      hl.FoldColumn.fg = colors.dark5
      hl.LineNrAbove.fg = colors.dark5
      hl.LineNrBelow.fg = colors.dark5
      hl.IncSearch.fg = colors.bg_popup
      hl.Pmenu.bg = colors.none

      hl.TelescopeTitle = { fg = colors.yellow }
      hl.NeoTreeDimText = { fg = colors.blue1 }
      hl.GitSignsCurrentLineBlame = { fg = colors.blue0 }
      -- hl.LspInlayHint.bg = "#000000"
    end,
  },
}
