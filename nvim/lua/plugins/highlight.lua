local cmd = vim.cmd
local dracula = require 'dracula'
local M = {}

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
function M.setup()
  dracula.setup {
    fox = "dracula", -- change the colorscheme to use nordfox
    styles = {
      comments = "italic", -- change style of comments to be italic
      keywords = "bold", -- change style of keywords to be bold
      functions = "italic,bold", -- styles can be a comma separated list
    },
    inverse = {
      match_paren = true, -- inverse the highlighting of match_parens
    },
    colors = {
      red = "#FF000", -- Override the red color for MAX POWER
      bg_alt = "#000000",
    },
    hlgroups = {
      TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
      LspCodeLens = { bg = "#000000", style = "italic" },
    },
  }

  -- Load the configuration set above and apply the colorscheme
  dracula.load()
end

-- customize dracula color palette
local draculaColors = {
  bg = "#282A36",
  fg = "#F8F8F2",
  selection = "#44475A",
  comment = "#6272A4",
  red = "#FF5555",
  orange = "#FFB86C",
  yellow = "#F1FA8C",
  green = "#50fa7b",
  purple = "#BD93F9",
  cyan = "#8BE9FD",
  pink = "#FF79C6",
  bright_red = "#FF6E6E",
  bright_green = "#69FF94",
  bright_yellow = "#FFFFA5",
  bright_blue = "#D6ACFF",
  bright_magenta = "#FF92DF",
  bright_cyan = "#A4FFFF",
  bright_white = "#FFFFFF",
  menu = "#21222C",
  visual = "#3E4452",
  gutter_fg = "#4B5263",
  nontext = "#3B4048",
}
vim.g.dracula_colors = draculaColors 
-- show the '~' characters after the end of buffers
vim.g.dracula_show_end_of_buffer = true
-- use transparent background
vim.g.dracula_transparent_bg = true
-- set custom lualine background color
vim.g.dracula_lualine_bg_color = "#44475a"
-- set italic comment
vim.g.dracula_italic_comment = true

-- print(colors)
--
local colors = {
  white = "#abb2bf",
  darker_black = "#fff",
  black = "#1e222a", --  nvim bg
  active_tab_bg = "#3D4E42",
  black2 = "#252931",
  one_bg = "#282c34", -- real bg of onedark
  one_bg2 = "#353b45",
  one_bg3 = "#30343c",
  grey = "#42464e",
  grey_fg = "#565c64",
  grey_fg2 = "#6f737b",
  light_grey = "#6f737b",
  red = "#d47d85",
  baby_pink = "#DE8C92",
  pink = "#ff75a0",
  line = "#7eca9c", -- for lines like vertsplit
  indentBlankline = "#6f737b", -- Intdent lines color
  green = "#A3BE8C",
  vibrant_green = "#7eca9c",
  nord_blue = "#81A1C1",
  blue = "#61afef",
  yellow = "#e7c787",
  sun = "#EBCB8B",
  purple = "#b4bbc8",
  dark_purple = "#c882e7",
  teal = "#519ABA",
  orange = "#fca2aa",
  cyan = "#a3b8ef",
  statusline_bg = "#22262e",
  lightbg = "#2d3139",
  lightbg2 = "#262a32"
}

local white = colors.white
local darker_black = colors.darker_black
local black = colors.black
local black2 = colors.black2
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local one_bg3 = colors.one_bg3
local light_grey = colors.light_grey
local grey = colors.grey
local grey_fg = colors.grey_fg
local red = colors.red
local line = colors.line
local indentBlankline = colors.indentBlankline
local green = colors.green
local nord_blue = colors.nord_blue
local blue = colors.blue
local yellow = colors.yellow
local purple = colors.purple
local active_tab_bg = colors.active_tab_bg

-- -- -- for guifg , bg

local function fg(group, color)
    cmd("hi " .. group .. " guifg=" .. color)
end

local function bg(group, color)
    cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- blankline
fg("IndentBlanklineChar", indentBlankline)

-- misc --
fg("LineNr", grey)
fg("Comment", grey)
fg("NvimInternalError", red)
fg("VertSplit", line)
fg("EndOfBuffer", black)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", green)
bg("PmenuThumb", nord_blue)

-- inactive statuslines as thin splitlines
cmd("hi! StatusLineNC gui=underline guifg=" .. line)

-- line n.o
cmd "hi clear CursorLine"
fg("cursorlinenr", white)

-- git signs ---
fg_bg("DiffAdd", nord_blue, "none")
fg_bg("DiffChange", one_bg2, "none")
fg_bg("DiffModified", nord_blue, "none")

-- NvimTree
fg("NvimTreeFolderIcon", blue)
fg("NvimTreeFolderName", blue)
fg("NvimTreeIndentMarker", one_bg2)
fg("NvimTreeVertSplit", darker_black)
bg("NvimTreeVertSplit", darker_black)

fg("NvimTreeRootFolder", darker_black)
bg("NvimTreeNormal", darker_black)
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)

-- telescope
fg("TelescopeBorder", line)
fg("TelescopePromptBorder", line)
fg("TelescopeResultsBorder", line)
fg("TelescopePreviewBorder",  line)

-- LspDiagnostics ---

-- error / warnings
fg("LspDiagnosticsSignError", red)
fg("LspDiagnosticsVirtualTextError", red)
fg("LspDiagnosticsSignWarning", yellow)
fg("LspDiagnosticsVirtualTextWarning", yellow)

-- info
fg("LspDiagnosticsSignInformation", green)
fg("LspDiagnosticsVirtualTextInformation", green)

-- hint
fg("LspDiagnosticsSignHint", purple)
fg("LspDiagnosticsVirtualTextHint", purple)

-- fg("MatchWord", purple)

-- bufferline

fg_bg("BufferLineFill", grey_fg, black2)
fg_bg("BufferLineBackground", light_grey, black2)

fg_bg("BufferLineBufferVisible", light_grey, black2)
fg_bg("BufferLineBufferSelected", white, active_tab_bg)

cmd "hi BufferLineBufferSelected gui=bold"

-- tabs
fg_bg("BufferLineTab", light_grey, one_bg3)
fg_bg("BufferLineTabSelected", black2, nord_blue)
fg_bg("BufferLineTabClose", red, active_tab_bg)

fg_bg("BufferLineIndicator", black2, black2)
fg_bg("BufferLineIndicatorSelected",  active_tab_bg,  active_tab_bg)

-- separators
fg_bg("BufferLineSeparator", line, black2)
fg_bg("BufferLineSeparatorVisible", line, black2)
fg_bg("BufferLineSeparatorSelected",  active_tab_bg, black2)

-- modified buffers
fg_bg("BufferLineModified", red, black2)
fg_bg("BufferLineModifiedVisible", red, black2)
fg_bg("BufferLineModifiedSelected", green,  active_tab_bg)

-- close buttons
fg_bg("BufferLineCLoseButtonVisible", light_grey, black2)
fg_bg("BufferLineCLoseButton", light_grey, black2)
fg_bg("BufferLineCLoseButtonSelected", red, active_tab_bg)

-- dashboard

fg("DashboardHeader", grey_fg)
fg("DashboardCenter", grey_fg)
fg("DashboardShortcut", grey_fg)
fg("DashboardFooter", black)

return M
