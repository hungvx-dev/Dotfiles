local M = {}

M.colors = {
  none = "NONE",
  bg = "NONE",
  fg = "#ffffff",
  bg_search = "#3d59a1",
  -- dark = "#6677c6",
  fg_gutter = "#3b4261",
  black = "#000000",

  fg_dark = "#fff8f0",
  fg_sidebar = "#fff8f0",

  border_highlight = "#00ffff",
  bg_statusline = "NONE",

  green = "#ccff33",
  green1 = "#33FFCF",
  blue = "#3B93F7",
  blue0 = "#0969D7",
  blue1 = "#0AEFFF",
  blue2 = "#0db9d7",
  blue5 = "#9be3ff",
  blue6 = "#8cfffe",

  yellow = "#FFEB0A",
  cyan = "#00FFFF",
  magenta = "#FF0F80",
  orange = "#fb8500",
  purple = "#DE85FF",
  red = "#ff5a5f",
  red1 = "#d90429",
  teal = "#02c39a",
  dark3 = "#545c7e",
  dark5 = "#6677c6",

  diff = { -- Git conflict
    add = "#20303b",
    change = "#1f2231",
    delete = "#37222c",
    text = "#394b70",
  },
  git = {
    add = "#00E4F5",
    change = "#00F58F",
    delete = "#B80000",
    ignore = "#545c7e",
  },

  error = "#F2181B",
  hint = "#02c39a",
  info = "#73d2de",
  warning = "#FFDA1F",
  todo = "#4895ef",
}

M.lualine = function()
  local hl = {}

  hl.normal = {
    a = { bg = M.colors.blue, fg = M.colors.white },
    b = { bg = M.colors.fg_gutter, fg = M.colors.blue },
    c = { bg = M.colors.bg_statusline, fg = M.colors.fg_sidebar },
  }

  hl.insert = {
    a = { bg = M.colors.green, fg = M.colors.black },
    b = { bg = M.colors.fg_gutter, fg = M.colors.green },
  }

  hl.command = {
    a = { bg = M.colors.yellow, fg = M.colors.black },
    b = { bg = M.colors.fg_gutter, fg = M.colors.yellow },
  }

  hl.visual = {
    a = { bg = M.colors.magenta, fg = M.colors.black },
    b = { bg = M.colors.fg_gutter, fg = M.colors.magenta },
  }

  hl.replace = {
    a = { bg = M.colors.red, fg = M.colors.black },
    b = { bg = M.colors.fg_gutter, fg = M.colors.red },
  }

  hl.terminal = {
    a = { bg = M.colors.green1, fg = M.colors.black },
    b = { bg = M.colors.fg_gutter, fg = M.colors.green1 },
  }

  hl.inactive = {
    a = { bg = M.colors.bg_statusline, fg = M.colors.blue },
    b = { bg = M.colors.bg_statusline, fg = M.colors.fg_gutter, gui = "bold" },
    c = { bg = M.colors.bg_statusline, fg = M.colors.fg_gutter },
  }

  return hl
end

M.base = {
  default = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },
  cursor = {
    bg = M.colors.bg,
    fg = M.colors.cyan,
  },
  transparent = {
    bg = M.colors.bg,
  },
}

M.highlights = {
  ["@annotation"] = "PreProc",
  ["@attribute"] = "PreProc",
  ["@boolean"] = "Boolean",
  ["@character"] = "Character",
  ["@character.printf"] = "SpecialChar",
  ["@character.special"] = "SpecialChar",
  ["@comment"] = "Comment",
  ["@comment.error"] = {
    fg = M.colors.error,
  },
  ["@comment.hint"] = {
    fg = M.colors.hint,
  },
  ["@comment.info"] = {
    fg = M.colors.info,
  },
  ["@comment.note"] = {
    fg = M.colors.hint,
  },
  ["@comment.todo"] = {
    fg = M.colors.todo,
  },
  ["@comment.warning"] = {
    fg = M.colors.warning,
  },
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Special",
  ["@constant.macro"] = "Define",
  ["@constructor"] = {
    fg = M.colors.magenta,
  },
  ["@constructor.tsx"] = {
    fg = M.colors.blue1,
  },
  ["@diff.delta"] = "DiffChange",
  ["@diff.minus"] = "DiffDelete",
  ["@diff.plus"] = "DiffAdd",
  ["@function"] = "Function",
  ["@function.builtin"] = "Special",
  ["@function.call"] = "@function",
  ["@function.macro"] = "Macro",
  ["@function.method"] = "Function",
  ["@function.method.call"] = "@function.method",
  ["@keyword"] = {
    fg = M.colors.purple,
    italic = true,
  },
  ["@keyword.conditional"] = "Conditional",
  ["@keyword.coroutine"] = "@keyword",
  ["@keyword.debug"] = "Debug",
  ["@keyword.directive"] = "PreProc",
  ["@keyword.directive.define"] = "Define",
  ["@keyword.exception"] = "Exception",
  ["@keyword.function"] = {
    fg = M.colors.magenta,
  },
  ["@keyword.import"] = "Include",
  ["@keyword.operator"] = "@operator",
  ["@keyword.repeat"] = "Repeat",
  ["@keyword.return"] = "@keyword",
  ["@keyword.storage"] = "StorageClass",
  ["@label"] = {
    fg = M.colors.blue,
  },
  ["@lsp.type.boolean"] = "@boolean",
  ["@lsp.type.builtinType"] = "@type.builtin",
  ["@lsp.type.comment"] = "@comment",
  ["@lsp.type.decorator"] = "@attribute",
  ["@lsp.type.deriveHelper"] = "@attribute",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.escapeSequence"] = "@string.escape",
  ["@lsp.type.formatSpecifier"] = "@markup.list",
  ["@lsp.type.generic"] = "@variable",
  ["@lsp.type.interface"] = {
    fg = M.colors.blue1,
  },
  ["@lsp.type.keyword"] = "@keyword",
  ["@lsp.type.lifetime"] = "@keyword.storage",
  ["@lsp.type.namespace"] = "@module",
  ["@lsp.type.namespace.python"] = "@variable",
  ["@lsp.type.number"] = "@number",
  ["@lsp.type.operator"] = "@operator",
  ["@lsp.type.parameter"] = "@variable.parameter",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.selfKeyword"] = "@variable.builtin",
  ["@lsp.type.selfTypeKeyword"] = "@variable.builtin",
  ["@lsp.type.string"] = "@string",
  ["@lsp.type.typeAlias"] = "@type.definition",
  ["@lsp.type.unresolvedReference"] = {
    sp = M.colors.error,
    undercurl = true,
  },
  ["@lsp.type.variable"] = {},
  ["@lsp.typemod.class.defaultLibrary"] = "@type.builtin",
  ["@lsp.typemod.enum.defaultLibrary"] = "@type.builtin",
  ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
  ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.keyword.async"] = "@keyword.coroutine",
  ["@lsp.typemod.keyword.injected"] = "@keyword",
  ["@lsp.typemod.macro.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.operator.injected"] = "@operator",
  ["@lsp.typemod.string.injected"] = "@string",
  ["@lsp.typemod.struct.defaultLibrary"] = "@type.builtin",
  ["@lsp.typemod.type.defaultLibrary"] = {
    fg = M.colors.blue1,
  },
  ["@lsp.typemod.typeAlias.defaultLibrary"] = {
    fg = M.colors.blue1,
  },
  ["@lsp.typemod.variable.callable"] = "@function",
  ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
  ["@lsp.typemod.variable.injected"] = "@variable",
  ["@lsp.typemod.variable.static"] = "@constant",
  ["@markup"] = "@none",
  ["@markup.emphasis"] = {
    italic = true,
  },
  ["@markup.environment"] = "Macro",
  ["@markup.environment.name"] = "Type",
  ["@markup.heading"] = "Title",
  ["@markup.heading.1.markdown"] = {
    bold = true,
    fg = M.colors.blue,
  },
  ["@markup.heading.2.markdown"] = {
    bold = true,
    fg = M.colors.yellow,
  },
  ["@markup.heading.3.markdown"] = {
    bold = true,
    fg = M.colors.green,
  },
  ["@markup.heading.4.markdown"] = {
    bold = true,
    fg = M.colors.teal,
  },
  ["@markup.heading.5.markdown"] = {
    bold = true,
    fg = M.colors.magenta,
  },
  ["@markup.heading.6.markdown"] = {
    bold = true,
    fg = M.colors.purple,
  },
  ["@markup.heading.7.markdown"] = {
    bold = true,
    fg = M.colors.orange,
  },
  ["@markup.heading.8.markdown"] = {
    bold = true,
    fg = M.colors.red,
  },
  ["@markup.italic"] = {
    italic = true,
  },
  ["@markup.link"] = {
    fg = M.colors.teal,
  },
  ["@markup.link.label"] = "SpecialChar",
  ["@markup.link.label.symbol"] = "Identifier",
  ["@markup.link.url"] = "Underlined",
  ["@markup.list"] = {
    fg = M.colors.blue5,
  },
  ["@markup.list.checked"] = {
    fg = M.colors.green1,
  },
  ["@markup.list.markdown"] = {
    bold = true,
    fg = M.colors.orange,
  },
  ["@markup.list.unchecked"] = {
    fg = M.colors.cyan,
  },
  ["@markup.math"] = "Special",
  ["@markup.raw"] = "String",
  ["@markup.raw.markdown_inline"] = {
    bg = "#414868",
    fg = M.colors.blue,
  },
  ["@markup.strikethrough"] = {
    strikethrough = true,
  },
  ["@markup.strong"] = {
    bold = true,
  },
  ["@markup.underline"] = {
    underline = true,
  },
  ["@module"] = "Include",
  ["@module.builtin"] = {
    fg = M.colors.red,
  },
  ["@namespace.builtin"] = "@variable.builtin",
  ["@none"] = {},
  ["@number"] = "Number",
  ["@number.float"] = "Float",
  ["@operator"] = {
    fg = M.colors.blue5,
  },
  ["@property"] = {
    fg = M.colors.green1,
  },
  ["@punctuation.bracket"] = {
    fg = M.colors.fg_dark,
  },
  ["@punctuation.delimiter"] = {
    fg = M.colors.blue5,
  },
  ["@punctuation.special"] = {
    fg = M.colors.blue5,
  },
  ["@punctuation.special.markdown"] = {
    fg = M.colors.orange,
  },
  ["@string"] = "String",
  ["@string.documentation"] = {
    fg = M.colors.yellow,
  },
  ["@string.escape"] = {
    fg = M.colors.magenta,
  },
  ["@string.regexp"] = {
    fg = M.colors.blue6,
  },
  ["@tag"] = "Label",
  ["@tag.attribute"] = "@property",
  ["@tag.delimiter"] = "Delimiter",
  ["@tag.delimiter.tsx"] = {
    fg = "#5d7ab8",
  },
  ["@tag.javascript"] = {
    fg = M.colors.red,
  },
  ["@tag.tsx"] = {
    fg = M.colors.red,
  },
  ["@type"] = "Type",
  ["@type.builtin"] = {
    fg = M.colors.blue1,
  },
  ["@type.definition"] = "Typedef",
  ["@type.qualifier"] = "@keyword",
  ["@variable"] = {
    fg = M.colors.fg,
  },
  ["@variable.builtin"] = {
    fg = M.colors.red,
  },
  ["@variable.member"] = {
    fg = M.colors.green1,
  },
  ["@variable.parameter"] = {
    fg = M.colors.yellow,
  },
  ["@variable.parameter.builtin"] = {
    fg = "#dab484",
  },

  Include = {
    fg = M.colors.magenta,
  },
  PreProc = {
    fg = M.colors.cyan,
  },
  Function = {
    fg = M.colors.blue,
  },
  String = {
    fg = M.colors.green,
  },
  Constant = {
    fg = M.colors.orange,
  },
  Character = {
    fg = M.colors.green,
  },
  Special = {
    fg = M.colors.blue1,
  },
  Delimiter = "Special",
  Comment = {
    fg = "#565f89",
    italic = true,
  },
  Statement = {
    fg = M.colors.magenta,
  },
  Debug = {
    fg = M.colors.orange,
  },
  Type = {
    fg = M.colors.blue1,
  },
  Title = {
    bold = true,
    fg = M.colors.blue,
  },
  Identifier = {
    fg = M.colors.magenta,
  },
  Underlined = {
    underline = true,
  },
  DiffAdd = {
    bg = M.colors.diff.add,
  },
  DiffChange = {
    bg = M.colors.diff.change,
  },
  DiffDelete = {
    bg = M.colors.diff.delete,
  },
  DiffText = {
    bg = M.colors.diff.text,
  },
  DiagnosticError = {
    fg = M.colors.error,
  },
  DiagnosticHint = {
    fg = M.colors.hint,
  },
  DiagnosticInfo = {
    fg = M.colors.info,
  },
  DiagnosticInformation = "DiagnosticInfo",
  DiagnosticUnderlineError = {
    sp = M.colors.error,
    undercurl = true,
  },
  DiagnosticUnderlineHint = {
    sp = M.colors.hint,
    undercurl = true,
  },
  DiagnosticUnderlineInfo = {
    sp = M.colors.info,
    undercurl = true,
  },
  DiagnosticUnderlineWarn = {
    sp = M.colors.warning,
    undercurl = true,
  },
  DiagnosticUnnecessary = {
    fg = "#414868",
  },
  DiagnosticVirtualTextError = {
    bg = "#2d202a",
    fg = M.colors.error,
  },
  DiagnosticVirtualTextHint = {
    bg = "#1a2b32",
    fg = M.colors.hint,
  },
  DiagnosticVirtualTextInfo = {
    bg = "#192b38",
    fg = M.colors.info,
  },
  DiagnosticVirtualTextWarn = {
    bg = "#2e2a2d",
    fg = M.colors.warning,
  },
  DiagnosticWarn = {
    fg = M.colors.warning,
  },
  DiagnosticWarning = "DiagnosticWarn",

  Normal = M.base.default,
  NormalFloat = M.base.default,
  NormalNC = M.base.default,
  NormalSB = M.base.default,

  Pmenu = M.base.default,
  PmenuMatch = M.base.cursor,
  PmenuMatchSel = M.base.cursor,
  PmenuSbar = M.base.transparent,
  PmenuSel = {
    bg = M.colors.bg,
    sp = M.colors.cyan,
    underline = true,
  },
  PmenuThumb = {
    bg = M.colors.cyan,
  },

  FloatShadow = M.base.transparent,
  FloatShadowThrough = M.base.transparent,
  FloatBorder = M.base.cursor,
  FloatTitle = M.base.cursor,

  Visual = {
    bg = M.colors.bg_search,
  },

  IncSearch = {
    bg = M.colors.orange,
    fg = M.colors.black,
  },
  Search = {
    bg = M.colors.bg_search,
    fg = M.colors.fg,
  },

  WinSeparator = {
    bold = true,
    fg = M.colors.cyan,
  },

  CurSearch = {
    bg = M.colors.orange,
    fg = M.colors.black,
  },
  Cursor = {
    bg = M.colors.fb,
    fg = M.colors.bg,
  },
  CursorColumn = {
    bg = "#292e42",
  },
  CursorIM = {
    bg = M.colors.fb,
    fg = M.colors.bg,
  },
  CursorLine = {
    bg = M.colors.bg,
    sp = M.colors.cyan,
    underline = true,
  },
  CursorLineNr = {
    bold = true,
    fg = M.colors.cyan,
  },

  MatchParen = {
    bold = true,
    fg = M.colors.none,
    bg = M.colors.bg_search,
  },

  LineNrAbove = {
    fg = M.colors.dark5,
  },
  LineNrBelow = {
    fg = M.colors.dark5,
  },

  Folded = {
    bg = M.colors.bg_search,
    fg = M.colors.cyan
  },

  AlphaButtons = {
    fg = M.colors.cyan,
  },
  AlphaFooter = {
    fg = M.colors.blue1,
  },
  AlphaHeader = {
    fg = M.colors.blue,
  },
  AlphaHeaderLabel = {
    fg = M.colors.orange,
  },
  AlphaShortcut = {
    fg = M.colors.orange,
  },

  NeoTreeDimText = {
    fg = M.colors.cyan,
  },
  NeoTreeFileName = {
    fg = M.colors.fg,
  },
  NeoTreeGitModified = {
    fg = M.colors.orange,
  },
  NeoTreeGitStaged = {
    fg = M.colors.green1,
  },
  NeoTreeGitUntracked = {
    fg = "#bb9af7",
  },
  NeoTreeNormal = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },
  NeoTreeNormalNC = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },
  NeoTreeTabActive = {
    bg = M.colors.bg,
    bold = true,
    fg = M.colors.blue,
  },
  NeoTreeTabInactive = {
    bg = M.colors.bg,
    fg = M.colors.dark3,
  },
  NeoTreeTabSeparatorActive = {
    bg = M.colors.bg,
    fg = M.colors.blue,
  },
  NeoTreeTabSeparatorInactive = {
    bg = M.colors.bg,
    fg = M.colors.black,
  },
  NeoTreeCursorLine = {
    bg = M.colors.bg,
    sp = M.colors.cyan,
    underline = true,
  },

  FzfLuaBorder = {
    bg = M.colors.bg,
    fg = M.colors.border_highlight,
  },
  FzfLuaPreviewTitle = {
    bg = M.colors.bg,
    fg = M.colors.orange,
  },
  FzfLuaTitle = {
    bg = M.colors.bg,
    fg = M.colors.orange,
  },
  -- FzfLuaLiveSym = "FzfLuaFzfPointer",
  -- FzfLuaLiveSym = "FzfLuaFzfPointer",
  -- FzfLuaCursor = "IncSearch",
  -- FzfLuaDirPart = {
  --   fg = M.colors.fg_dark,
  -- },
  -- FzfLuaFilePart = "FzfLuaFzfNormal",
  -- FzfLuaFzfCursorLine = "Visual",
  -- FzfLuaFzfNormal = {
  --   fg = M.colors.fg,
  -- },
  -- FzfLuaFzfPointer = {
  --   fg = M.colors.magenta,
  -- },
  -- FzfLuaFzfSeparator = {
  --   bg = M.colors.bg,
  --   fg = M.colors.orange,
  -- },
  -- FzfLuaHeaderBind = "@punctuation.special",
  -- FzfLuaHeaderText = "Title",
  FzfLuaNormal = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },
  -- FzfLuaPath = "Directory",

  Directory = {
    fg = "#74a2ff",
  },
  TabLineSel = {
    bg = M.colors.none,
    fg = M.colors.cyan,
  },

  BlinkCmpLabelMatch = {
    bg = M.colors.bg,
    fg = "#d7005f",
  },
  BlinkCmpGhostText = {
    fg = "#414868",
  },
  BlinkCmpMenuBorder = "FloatBorder",
  BlinkCmpDocBorder = "FloatBorder",
  BlinkCmpSignatureHelpBorder = "FloatBorder",
  BlinkCmpDoc = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },
  BlinkCmpKindArray = "LspKindArray",
  BlinkCmpKindBoolean = "LspKindBoolean",
  BlinkCmpKindClass = "LspKindClass",
  BlinkCmpKindCodeium = {
    bg = M.colors.bg,
    fg = M.colors.teal,
  },
  BlinkCmpKindColor = "LspKindColor",
  BlinkCmpKindConstant = "LspKindConstant",
  BlinkCmpKindConstructor = "LspKindConstructor",
  BlinkCmpKindCopilot = {
    bg = M.colors.bg,
    fg = M.colors.teal,
  },
  BlinkCmpKindDefault = {
    bg = M.colors.bg,
    fg = M.colors.fg_dark,
  },
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
    bg = M.colors.none,
    fg = M.colors.teal,
  },
  BlinkCmpKindTabNine = {
    bg = M.colors.none,
    fg = M.colors.teal,
  },
  BlinkCmpKindText = "LspKindText",
  BlinkCmpKindTypeParameter = "LspKindTypeParameter",
  BlinkCmpKindUnit = "LspKindUnit",
  BlinkCmpKindValue = "LspKindValue",
  BlinkCmpKindVariable = "LspKindVariable",
  BlinkCmpLabel = {
    bg = M.colors.none,
    fg = M.colors.fg_dark,
  },
  BlinkCmpLabelDeprecated = {
    bg = M.colors.none,
    fg = M.colors.fg_gutter,
    strikethrough = true,
  },
  BlinkCmpMenu = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },
  BlinkCmpSignatureHelp = {
    bg = M.colors.bg,
    fg = M.colors.fg,
  },

  MiniIconsAzure = {
    fg = M.colors.blue2,
  },
  MiniIconsBlue = {
    fg = M.colors.blue,
  },
  MiniIconsCyan = {
    fg = M.colors.cyan,
  },
  MiniIconsGreen = {
    fg = M.colors.green,
  },
  MiniIconsGrey = {
    fg = M.colors.fg,
  },
  MiniIconsOrange = {
    fg = M.colors.orange,
  },
  MiniIconsPurple = {
    fg = M.colors.purple,
  },
  MiniIconsRed = {
    fg = M.colors.red,
  },
  MiniIconsYellow = {
    fg = M.colors.yellow,
  },
  GitSignsAdd = {
    fg = M.colors.git.add,
  },
  GitSignsChange = {
    fg = M.colors.git.change,
  },
  GitSignsDelete = {
    fg = M.colors.git.delete,
  },

  RainbowDelimiterRed = {
    fg = "#fc5f66",
  },
  RainbowDelimiterYellow = {
    fg = M.colors.yellow,
  },
  RainbowDelimiterBlue = {
    fg = "#24aeee",
  },
  RainbowDelimiterOrange = {
    fg = "#fb8500",
  },
  RainbowDelimiterGreen = {
    fg = M.colors.green,
  },
  RainbowDelimiterViolet = {
    fg = "#b67cff",
  },
  RainbowDelimiterCyan = {
    fg = "#00FFFF",
  },

  CleverFDefaultLabel = {
    fg = "#ff7788",
    underline = true,
  },
  EyelinerPrimary = {
    fg = "#ff1122",
    underline = false,
    bold = true,
  },
  EyelinerSecondary = {
    fg = "#afff5f",
    underline = false,
  },
}

return M
