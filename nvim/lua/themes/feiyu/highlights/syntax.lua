local colors = require("themes.feiyu.colors")
local M = {}
M.base = {
  Comment = {
    fg = colors.comment,
    italic = true,
  },
  Constant = {
    fg = colors.orange1,
  },
  String = {
    fg = colors.orange,
  },
  Character = {
    fg = colors.green,
  },
  Identifier = {
    fg = colors.purple,
  },
  Function = {
    fg = colors.blue,
    italic = true,
  },
  Statement = {
    fg = colors.purple,
    -- bold = true,
  },
  Operator = {
    fg = colors.blue5,
  },
  Keyword = {
    fg = colors.purple,
    italic = true,
  },
  KeywordSpecial = {
    fg = colors.magenta,
    italic = true,
  },
  PreProc = {
    fg = colors.cyan,
  },
  Type = {
    fg = colors.blue1,
  },
  Special = {
    fg = colors.red,
  },
  Delimiter = {
    fg = colors.red,
  },
  Title = {
    fg = colors.blue,
    bold = true,
  },

  -- INFO: Default

  -- Number = "Constant",
  -- Boolean = "Constant",
  -- Float = "Number",
  -- Conditional = "Statement",
  -- Repeat = "Statement",
  -- Label = "Statement",
  -- Keyword = "Statement",
  -- Exception = "Statement",
  -- Include = "PreProc",
  -- Define = "PreProc",
  -- Macro = "PreProc",
  -- PreCondit = "PreProc"
  -- StorageClass = "Type"
  -- Structure = "Type"
  -- Typedef = "Type"
  -- SpecialChar = "Special"
  -- Tag = "Special"
  -- SpecialComment = "Special"
  -- Debug = "Special"
}

M.special = {
  ["@keyword.import"] = "KeywordSpecial",
  ["@keyword.exception"] = "KeywordSpecial",
  ["@keyword.coroutine"] = "KeywordSpecial",
  ["@keyword.operator"] = "KeywordSpecial",
  ["@keyword.return"] = "KeywordSpecial",
  ["@type.builtin"] = { fg = colors.violet, bold = true },
  ["@type.qualifier"] = "@keyword",

  ["@property"] = { fg = colors.green1 },
  ["@tag.attribute"] = "@property",
  ["@variable"] = { fg = colors.fg },
  ["@variable.member"] = "@property",
  ["@variable.parameter"] = { fg = colors.yellow },
  ["@variable.parameter.builtin"] = "@variable.parameter",

  ["@comment.hint"] = { fg = colors.hint },
  ["@comment.info"] = { fg = colors.info },
  ["@comment.note"] = { fg = colors.hint },
  ["@comment.hack"] = { fg = colors.yellow },
  ["@comment.todo"] = { fg = colors.todo },
  ["@comment.test"] = { fg = colors.purple },

  ["@markup.link"] = { fg = colors.teal, underline = true },
  -- ["@markup.link.label"] = "SpecialChar",
  ["@markup.environment"] = "Macro",
  ["@markup.environment.name"] = "Type",
  ["@markup.heading.1.markdown"] = { bold = true, fg = colors.blue },
  ["@markup.heading.2.markdown"] = { bold = true, fg = colors.yellow },
  ["@markup.heading.3.markdown"] = { bold = true, fg = colors.green },
  ["@markup.heading.4.markdown"] = { bold = true, fg = colors.teal },
  ["@markup.heading.5.markdown"] = { bold = true, fg = colors.magenta },
  ["@markup.heading.6.markdown"] = { bold = true, fg = colors.purple },
  ["@markup.heading.7.markdown"] = { bold = true, fg = colors.orange },
  ["@markup.heading.8.markdown"] = { bold = true, fg = colors.red },
  ["@markup.raw"] = "String",
  ["@markup.raw.markdown_inline"] = { bg = "#414868", fg = colors.blue },
  ["@lsp.type.variable"] = {},
  LspInlayHint = {
    bg = colors.none,
    fg = colors.dark3,
  },
}

M.lsp = {
  ["@lsp.type.enumMember"] = "@variable.member",
  ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
  -- ["@lsp.typemod.variable.readonly.typescript"] = "Constant",
  ["@lsp.typemod.type.defaultLibrary"] = "@type.builtin",

  LspKindArray = "@punctuation.bracket",
  LspKindBoolean = "@boolean",
  LspKindClass = "@type",
  LspKindColor = "Special",
  LspKindConstant = "@constant",
  LspKindConstructor = "@constructor",
  LspKindEnum = "@lsp.type.enum",
  LspKindEnumMember = "@lsp.type.enumMember",
  LspKindEvent = "Special",
  LspKindField = "@variable.member",
  LspKindFile = "Normal",
  LspKindFolder = "Directory",
  LspKindFunction = "@function",
  LspKindInterface = "@lsp.type.interface",
  LspKindKey = "@variable.member",
  LspKindKeyword = "@lsp.type.keyword",
  LspKindMethod = "@function.method",
  LspKindModule = "@module",
  LspKindNamespace = "@module",
  LspKindNull = "@constant.builtin",
  LspKindNumber = "@number",
  LspKindObject = "@constant",
  LspKindOperator = "@operator",
  LspKindPackage = "@module",
  LspKindProperty = "@property",
  LspKindReference = "@markup.link",
  LspKindSnippet = "Conceal",
  LspKindString = "@string",
  LspKindStruct = "@lsp.type.struct",
  LspKindText = "@markup",
  LspKindTypeParameter = "@lsp.type.typeParameter",
  LspKindUnit = "@lsp.type.struct",
  LspKindValue = "@string",
  LspKindVariable = "@variable",
}

return M
