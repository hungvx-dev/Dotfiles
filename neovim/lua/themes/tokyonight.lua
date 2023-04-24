local present, tokyonight = pcall(require, "tokyonight")
if not present then
  return
end
-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
tokyonight.setup {
  style = "night",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = "NONE",
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = {},
  day_brightness = 0.8,
  hide_inactive_statusline = true,
  dim_inactive = true,
  lualine_bold = false,

  on_colors = function(colors)
    colors.border = "#1A1B26"
    -- colors.purple = "#ee85c4"
    colors.blue = "#638ee8"
  end,

  on_highlights = function(hl, c)
    local prompt = "#FFA630"
    local text = "#488dff"
    local none = "NONE"

    hl.TelescopeTitle = { fg = prompt }
    hl.TelescopeNormal = { bg = none, fg = none }
    hl.TelescopeBorder = { bg = none, fg = text }
    hl.TelescopeMatching = { fg = prompt }

    hl.MsgArea = { fg = c.fg_dark }

    hl.NormalFloat.bg = none
    hl.NormalSB.bg = none
    hl.FloatBorder.bg = none
    hl.Pmenu.bg = none

    hl.NeoTreeNormal.bg = none
    hl.NeoTreeNormalNC.bg = none

    hl.StatusLine.bg = none
    hl.StatusLineNC.bg = none

    hl.TabLine.bg = none

    hl.TroubleNormal.bg = none

    hl.LspFloatWinNormal.bg = none
    hl.LspInfoBorder.bg = none

    hl.CmpDocumentation.bg = none
    hl.CmpDocumentationBorder.bg = none

    hl.MiniStatuslineInactive.bg = none
    hl.MiniTablineHidden.bg = none
    hl.MiniTablineModifiedHidden.bg = none
    hl.MiniTablineModifiedVisible.bg = none
    hl.MiniTablineTabpagesection.bg = none
    hl.MiniTablineVisible.bg = none
  end,
}
