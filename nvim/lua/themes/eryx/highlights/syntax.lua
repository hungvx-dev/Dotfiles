local colors = require("themes.eryx.colors")
local M = {}

M.base = {
  Comment = { fg = colors.gray, italic = true },
  Constant = { fg = colors.orange },
  String = { fg = colors.amber },
  Character = { fg = colors.green },
  Identifier = { fg = colors.purple },
  Function = { fg = colors.blue, italic = true },
  Statement = { fg = colors.purple },
  Operator = { fg = colors.sky },
  Keyword = { fg = colors.purple_1, italic = true },
  KeywordSpecial = { fg = colors.pink, italic = true },
  KeywordSpecial2 = { fg = colors.purple, italic = true },
  PreProc = { fg = colors.cyan },
  Type = { fg = colors.cyan },
  Special = { fg = colors.red_1 },
  Delimiter = { fg = colors.red_1 },
  Title = { fg = colors.blue, bold = true },

  -- INFO: Default.

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
  ["@keyword.type"] = "KeywordSpecial2",
  ["@keyword.function"] = "KeywordSpecial2",
  -- ["@keyword.conditional"] = "KeywordSpecial",
  ["@type.qualifier"] = "@keyword",

  ["@property"] = { fg = colors.teal_1 },
  ["@variable"] = { fg = colors.fg },
  ["@variable.member"] = "@property",
  ["@variable.parameter"] = { fg = colors.yellow },
  ["@variable.parameter.builtin"] = "@variable.parameter",

  ["@tag.attribute"] = { fg = colors.teal },
  ["@tag.tsx"] = "@type.tsx",
  ["@lsp.type.component"] = "@type.tsx",

  ["@comment.hint"] = { fg = colors.teal },
  ["@comment.info"] = { fg = colors.sky },
  ["@comment.note"] = { fg = colors.teal_1 },
  ["@comment.hack"] = { fg = colors.yellow },
  ["@comment.todo"] = { fg = colors.blue },
  ["@comment.test"] = { fg = colors.purple },

  ["@type.builtin"] = { fg = colors.red_1, bold = true },
  -- ["@variable.builtin"] = ,
  ["@function.builtin"] = { fg = colors.blue_1, italic = true },

  ["@lsp.type.enumMember"] = "@variable.member",
  -- ["@lsp.mod.readonly"] = "Constant",
  -- ["@lsp.mod.defaultLibrary"] = "@type.builtin",
  -- ["@lsp.typemod.variable.readonly"] = "Constant",
  -- ["@lsp.typemod.variable.defaultLibrary"] = { fg = colors.cyan_1, italic = true },
  -- ["@lsp.typemod.type.defaultLibrary"] = {},
  ["@lsp.typemod.class.defaultLibrary"] = "@type.builtin",
  ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",

  ["@constructor"] = "@lsp.type.class",
  --
  -- ["@lsp.typemod.namespace.defaultLibrary"] = "@variable.builtin",
  ["@lsp.type.variable"] = {},
  LspInlayHint = { bg = colors.none, fg = colors.slate },
  LspReferenceText = { bg = colors.slate_1 },

  ["@markup.link"] = { fg = colors.teal, underline = true },
  -- ["@markup.link.label"] = "SpecialChar",
  ["@markup.environment"] = "Macro",
  ["@markup.environment.name"] = "Type",
  ["@markup.heading.1.markdown"] = { bold = true, fg = colors.blue },
  ["@markup.heading.2.markdown"] = { bold = true, fg = colors.yellow },
  ["@markup.heading.3.markdown"] = { bold = true, fg = colors.green },
  ["@markup.heading.4.markdown"] = { bold = true, fg = colors.teal },
  ["@markup.heading.5.markdown"] = { bold = true, fg = colors.rose },
  ["@markup.heading.6.markdown"] = { bold = true, fg = colors.purple },
  ["@markup.heading.7.markdown"] = { bold = true, fg = colors.orange },
  ["@markup.heading.8.markdown"] = { bold = true, fg = colors.red_1 },
  ["@markup.raw"] = "String",
  ["@markup.raw.markdown_inline"] = { bg = "#414868", fg = colors.blue },
}

M.lsp = {
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
