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
  -- on_colors = function(colors)
  -- end,
  on_highlights = function(hl)
    local prompt = "#FFA630"
    local text = "#488dff"
    local none = "NONE"

    hl.CursorLineNr = { fg = "#EFFF00" }
    hl.TelescopeTitle = { fg = prompt }
    hl.TelescopeNormal = { bg = none, fg = none }
    hl.TelescopeMatching = { fg = prompt }

    hl.StatusLine = { bg = none }
    hl.StatusLineNC.bg = none
    hl.Pmenu.bg = none
    hl.Pmenu.fg = "#27a1b9"
    hl.PmenuSbar.bg = none
  end,
}
