local colors = require("themes.feiyu.colors")

local M = {}

M.git = {
  ["@diff.delta"] = "DiffChange",
  ["@diff.minus"] = "DiffDelete",
  ["@diff.plus"] = "DiffAdd",
  DiffAdd = { bg = colors.diff.add },
  DiffChange = { bg = colors.diff.change },
  DiffDelete = { bg = colors.diff.delete },
  DiffText = { bg = colors.diff.text },
  GitSignsAdd = { fg = colors.git.add },
  GitSignsChange = { fg = colors.git.change },
  GitSignsCurrentLineBlame = {
    -- bg = colors.blue0,
    bold = true,
    -- underline = true,
    fg = colors.dark3,
  },
  GitSignsDelete = { fg = colors.git.delete },

  -- GitGraphBranchName = {
  --   fg = colors.orange
  -- },
  -- GitGraphBranchMsg = {
  --   fg = colors.green
  -- },
  -- GitGraphTimestamp = {
  --   fg = colors.yellow
  -- },
  -- GitGraphHash = {
  --   fg = colors.violet
  -- },
  -- GitGraphAuthor = {
  --   fg = colors.blue
  -- },
}

M.neotree = {
  NeoTreeDimText = { fg = colors.blue5 },
  NeoTreeFileName = { fg = colors.fg },
  NeoTreeGitModified = { fg = colors.orange },
  NeoTreeGitStaged = { fg = colors.green1 },
  NeoTreeGitUntracked = { fg = "#bb9af7" },
  NeoTreeNormal = {
    bg = colors.bg,
    fg = colors.fg,
  },
  NeoTreeNormalNC = {
    bg = colors.bg,
    fg = colors.fg,
  },
  NeoTreeTabActive = {
    bold = true,
    bg = colors.bg,
    fg = colors.blue,
  },
  NeoTreeTabInactive = {
    bg = colors.bg,
    fg = colors.dark3,
  },
  NeoTreeTabSeparatorActive = {
    bg = colors.bg,
    fg = colors.blue,
  },
  NeoTreeTabSeparatorInactive = {
    bg = colors.bg,
    fg = colors.black,
  },
  NeoTreeCursorLine = {
    bg = colors.bg,
    sp = colors.cyan,
    underline = true,
  },
  -- NeoTreeWinSeparator = {
  --   fg = colors.cyan,
  -- },
  -- NeoTreeVertSplit = {
  --   fg = colors.red,
  -- },
}

M.blink_cmp = {
  BlinkCmpLabelMatch = {
    bg = colors.bg,
    fg = "#d7005f",
  },
  -- BlinkCmpLabelDescription = "Comment",
  BlinkCmpGhostText = {
    fg = "#414868",
  },
  BlinkCmpMenuBorder = "FloatBorder",
  BlinkCmpDocBorder = "FloatBorder",
  BlinkCmpSignatureHelpBorder = "FloatBorder",
  BlinkCmpLabelDeprecated = {
    bg = colors.none,
    fg = colors.fg_gutter,
    strikethrough = true,
  },

  BlinkCmpKindArray = "LspKindArray",
  BlinkCmpKindBoolean = "LspKindBoolean",
  BlinkCmpKindClass = "LspKindClass",
  BlinkCmpKindCodeium = {
    bg = colors.bg,
    fg = colors.teal,
  },
  BlinkCmpKindColor = "LspKindColor",
  BlinkCmpKindConstant = "LspKindConstant",
  BlinkCmpKindConstructor = "LspKindConstructor",
  BlinkCmpKindCopilot = {
    bg = colors.bg,
    fg = colors.teal,
  },
  -- BlinkCmpKindDefault = {
  --   bg = colors.bg,
  --   fg = colors.fg_dark,
  -- },
  BlinkCmpKindEnum = "LspKindEnum",
  BlinkCmpKindEnumMember = "LspKindEnumMember",
  BlinkCmpKindEvent = "LspKindEvent",
  BlinkCmpKindField = "LspKindField",
  BlinkCmpKindFile = "LspKindFile",
  BlinkCmpKindFolder = "LspKindFolder",
  BlinkCmpKindFunction = "LspKindFunction",
  BlinkCmpKindInterface = "LspKindInterface",
  BlinkCmpKindKey = "LspKindKey",
  BlinkCmpKindKeyword = "LspKindKeyword",
  BlinkCmpKindMethod = "LspKindMethod",
  BlinkCmpKindModule = "LspKindModule",
  BlinkCmpKindNamespace = "LspKindNamespace",
  BlinkCmpKindNull = "LspKindNull",
  BlinkCmpKindNumber = "LspKindNumber",
  BlinkCmpKindObject = "LspKindObject",
  BlinkCmpKindOperator = "LspKindOperator",
  BlinkCmpKindPackage = "LspKindPackage",
  BlinkCmpKindProperty = "LspKindProperty",
  BlinkCmpKindReference = "LspKindReference",
  BlinkCmpKindSnippet = "LspKindSnippet",
  BlinkCmpKindString = "LspKindString",
  BlinkCmpKindStruct = "LspKindStruct",
  BlinkCmpKindSupermaven = {
    bg = colors.none,
    fg = colors.teal,
  },
  BlinkCmpKindTabNine = {
    bg = colors.none,
    fg = colors.teal,
  },
  BlinkCmpKindText = "LspKindText",
  BlinkCmpKindTypeParameter = "LspKindTypeParameter",
  BlinkCmpKindUnit = "LspKindUnit",
  BlinkCmpKindValue = "LspKindValue",
  BlinkCmpKindVariable = "LspKindVariable",
}

M.alpha = {
  AlphaButtons = {
    fg = colors.cyan,
  },
  AlphaFooter = {
    fg = colors.blue1,
  },
  AlphaHeader = {
    fg = colors.blue,
  },
  AlphaHeaderLabel = {
    fg = colors.orange,
  },
  AlphaShortcut = {
    fg = colors.orange,
  },
}

M.mini_icon = {
  MiniIconsAzure = { fg = colors.blue2 },
  MiniIconsBlue = { fg = colors.blue },
  MiniIconsCyan = { fg = colors.cyan },
  MiniIconsGreen = { fg = colors.green },
  MiniIconsGrey = { fg = colors.fg },
  MiniIconsOrange = { fg = colors.orange },
  MiniIconsPurple = { fg = colors.purple },
  MiniIconsRed = { fg = colors.red },
  MiniIconsYellow = { fg = colors.yellow },
}

M.diagnostic = {
  DiagnosticError = { fg = colors.error },
  DiagnosticHint = { fg = colors.hint },
  DiagnosticInfo = { fg = colors.info },
  DiagnosticInformation = "DiagnosticInfo",
  DiagnosticUnderlineError = {
    sp = colors.error,
    undercurl = true,
  },
  DiagnosticUnderlineHint = {
    sp = colors.hint,
    undercurl = true,
  },
  DiagnosticUnderlineInfo = {
    sp = colors.info,
    undercurl = true,
  },
  DiagnosticUnderlineWarn = {
    sp = colors.warning,
    undercurl = true,
  },
  DiagnosticUnnecessary = { fg = "#8990b3" },
  DiagnosticWarn = { fg = colors.warning },
  DiagnosticWarning = "DiagnosticWarn",
  -- DiagnosticVirtualTextError = {
  --   bg = "#2d202a",
  --   fg = colors.error,
  -- },
  -- DiagnosticVirtualTextHint = {
  --   bg = "#1a2b32",
  --   fg = colors.hint,
  -- },
  -- DiagnosticVirtualTextInfo = {
  --   bg = "#192b38",
  --   fg = colors.info,
  -- },
  -- DiagnosticVirtualTextWarn = {
  --   bg = "#2e2a2d",
  --   fg = colors.warning,
  -- },
}

M.fzf = {
  FzfLuaBorder = {
    bg = colors.bg,
    fg = colors.border_highlight,
  },
  FzfLuaPreviewTitle = {
    bg = colors.bg,
    fg = colors.orange,
  },
  FzfLuaTitle = {
    bg = colors.bg,
    fg = colors.orange,
  },
  FzfLuaNormal = {
    bg = colors.bg,
    fg = colors.fg,
  },
  -- FzfLuaLiveSym = "FzfLuaFzfPointer",
  -- FzfLuaLiveSym = "FzfLuaFzfPointer",
  -- FzfLuaCursor = "IncSearch",
  -- FzfLuaDirPart = {
  --   fg = colors.fg_dark,
  -- },
  -- FzfLuaFilePart = "FzfLuaFzfNormal",
  -- FzfLuaFzfCursorLine = "Visual",
  -- FzfLuaFzfNormal = {
  --   fg = colors.fg,
  -- },
  -- FzfLuaFzfPointer = {
  --   fg = colors.magenta,
  -- },
  -- FzfLuaFzfSeparator = {
  --   bg = colors.bg,
  --   fg = colors.orange,
  -- },
  -- FzfLuaHeaderBind = "@punctuation.special",
  -- FzfLuaHeaderText = "Title",
  -- FzfLuaPath = "Directory",
}

M.statusline = {
  StModeNormal = {
    bg = colors.cyan,
    fg = colors.black,
  },
  StModeInsert = {
    bg = colors.green,
    fg = colors.black,
  },
  StModeVisual = {
    bg = colors.magenta,
    fg = colors.fg,
  },
  StModeReplace = {
    bg = colors.red,
    fg = colors.fg,
  },
  StModeCommand = {
    bg = colors.yellow,
    fg = colors.black,
  },
  StModeDefault = {
    bg = colors.blue,
    fg = colors.black,
  },
  StModeNormalSeparator = {
    fg = colors.cyan,
    bg = colors.fg_gutter,
  },
  StModeInsertSeparator = {
    fg = colors.green,
    bg = colors.fg_gutter,
  },
  StModeVisualSeparator = {
    fg = colors.magenta,
    bg = colors.fg_gutter,
  },
  StModeReplaceSeparator = {
    fg = colors.red,
    bg = colors.fg_gutter,
  },
  StModeCommandSeparator = {
    fg = colors.yellow,
    bg = colors.fg_gutter,
  },
  StModeTerminalSeparator = {
    fg = colors.green1,
    bg = colors.fg_gutter,
  },
  StModeDefaultSeparator = {
    fg = colors.blue,
    bg = colors.fg_gutter,
  },
  StGitIcon = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  StBranchName = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  StBranchNameSeparator = {
    fg = colors.fg_gutter,
  },
  StSectionY = {
    bg = colors.fg_gutter,
    fg = colors.orange,
  },
  StSectionYSeparator = {
    fg = colors.fg_gutter,
  },
  -- StSectionY = {
  --   bg = colors.fg_gutter,
  --   fg = colors.orange,
  -- },
  -- StSectionYSeparator = {
  --   fg = colors.fg_gutter,
  -- },
  StSeparator = {
    fg = colors.cyan,
  },
}

M.telescope = {
  TelescopeBorder = "FloatBorder",
  TelescopeSelection = "CursorLine",
  TelescopePreviewLine = "CursorLine",
}

return M
