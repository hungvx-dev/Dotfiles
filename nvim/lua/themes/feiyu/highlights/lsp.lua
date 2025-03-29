local colors = require("themes.feiyu.colors")

return {
  Include = {
    fg = colors.magenta,
  },
  PreProc = {
    fg = colors.cyan,
  },
  Function = {
    fg = colors.blue,
  },
  String = {
    fg = colors.green,
  },
  Constant = {
    fg = colors.orange,
  },
  Character = {
    fg = colors.green,
  },
  Special = {
    fg = colors.blue1,
  },
  Delimiter = "Special",
  Comment = {
    fg = colors.comment,
    italic = true,
  },
  Statement = {
    fg = colors.magenta,
  },
  Debug = {
    fg = colors.orange,
  },
  Type = {
    fg = colors.blue1,
  },
  Title = {
    bold = true,
    fg = colors.blue,
  },
  Identifier = {
    fg = colors.magenta,
  },
  Underlined = {
    underline = true,
  },
  ["@annotation"] = "PreProc",
  ["@attribute"] = "PreProc",
  ["@boolean"] = "Boolean",
  ["@character"] = "Character",
  ["@character.printf"] = "SpecialChar",
  ["@character.special"] = "SpecialChar",
  ["@comment"] = "Comment",
  ["@comment.error"] = {
    fg = colors.error,
  },
  ["@comment.hint"] = {
    fg = colors.hint,
  },
  ["@comment.info"] = {
    fg = colors.info,
  },
  ["@comment.note"] = {
    fg = colors.hint,
  },
  ["@comment.hack"] = {
    fg = colors.yellow,
  },
  ["@comment.todo"] = {
    fg = colors.todo,
  },
  ["@comment.warning"] = {
    fg = colors.warning,
  },
  ["@comment.test"] = {
    fg = colors.purple,
  },
  ["@constant"] = "Constant",
  ["@constant.builtin"] = "Special",
  ["@constant.macro"] = "Define",
  ["@constructor"] = {
    fg = colors.magenta,
  },
  ["@constructor.tsx"] = {
    fg = colors.blue1,
  },
  ["@function"] = "Function",
  -- ["@function.builtin"] = "Special",
  ["@function.builtin"] = "Function",
  ["@function.call"] = "@function",
  ["@function.macro"] = "Macro",
  ["@function.method"] = "Function",
  ["@function.method.call"] = "@function.method",
  ["@keyword"] = {
    fg = colors.purple,
    italic = true,
  },
  ["@keyword.conditional"] = "Conditional",
  ["@keyword.coroutine"] = "@keyword",
  ["@keyword.debug"] = "Debug",
  ["@keyword.directive"] = "PreProc",
  ["@keyword.directive.define"] = "Define",
  ["@keyword.exception"] = "Exception",
  ["@keyword.function"] = {
    fg = colors.magenta,
  },
  ["@keyword.import"] = "Include",
  ["@keyword.operator"] = "@operator",
  ["@keyword.repeat"] = "Repeat",
  ["@keyword.return"] = "@keyword",
  ["@keyword.storage"] = "StorageClass",
  ["@label"] = {
    fg = colors.blue,
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
    fg = colors.blue1,
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
    sp = colors.error,
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
    fg = colors.blue1,
  },
  ["@lsp.typemod.typeAlias.defaultLibrary"] = {
    fg = colors.blue1,
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
    fg = colors.blue,
  },
  ["@markup.heading.2.markdown"] = {
    bold = true,
    fg = colors.yellow,
  },
  ["@markup.heading.3.markdown"] = {
    bold = true,
    fg = colors.green,
  },
  ["@markup.heading.4.markdown"] = {
    bold = true,
    fg = colors.teal,
  },
  ["@markup.heading.5.markdown"] = {
    bold = true,
    fg = colors.magenta,
  },
  ["@markup.heading.6.markdown"] = {
    bold = true,
    fg = colors.purple,
  },
  ["@markup.heading.7.markdown"] = {
    bold = true,
    fg = colors.orange,
  },
  ["@markup.heading.8.markdown"] = {
    bold = true,
    fg = colors.red,
  },
  ["@markup.italic"] = {
    italic = true,
  },
  ["@markup.link"] = {
    fg = colors.teal,
  },
  ["@markup.link.label"] = "SpecialChar",
  ["@markup.link.label.symbol"] = "Identifier",
  ["@markup.link.url"] = "Underlined",
  ["@markup.list"] = {
    fg = colors.blue5,
  },
  ["@markup.list.checked"] = {
    fg = colors.green1,
  },
  ["@markup.list.markdown"] = {
    bold = true,
    fg = colors.orange,
  },
  ["@markup.list.unchecked"] = {
    fg = colors.cyan,
  },
  ["@markup.math"] = "Special",
  ["@markup.raw"] = "String",
  ["@markup.raw.markdown_inline"] = {
    bg = "#414868",
    fg = colors.blue,
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
    fg = colors.red,
  },
  ["@namespace.builtin"] = "@variable.builtin",
  ["@none"] = {},
  ["@number"] = "Number",
  ["@number.float"] = "Float",
  ["@operator"] = {
    fg = colors.blue5,
  },
  ["@property"] = {
    fg = colors.green1,
  },
  ["@punctuation.bracket"] = {
    fg = colors.fg_dark,
  },
  ["@punctuation.delimiter"] = {
    fg = colors.blue5,
  },
  ["@punctuation.special"] = {
    fg = colors.blue5,
  },
  ["@punctuation.special.markdown"] = {
    fg = colors.orange,
  },
  ["@string"] = "String",
  ["@string.documentation"] = {
    fg = colors.yellow,
  },
  ["@string.escape"] = {
    fg = colors.magenta,
  },
  ["@string.regexp"] = {
    fg = colors.blue6,
  },
  ["@tag"] = "Label",
  ["@tag.attribute"] = "@property",
  ["@tag.delimiter"] = "Delimiter",
  ["@tag.delimiter.tsx"] = {
    fg = "#5d7ab8",
  },
  ["@tag.javascript"] = {
    fg = colors.red,
  },
  ["@tag.tsx"] = {
    fg = colors.red,
  },
  ["@type"] = "Type",
  ["@type.builtin"] = {
    fg = colors.blue1,
  },
  ["@type.definition"] = "Typedef",
  ["@type.qualifier"] = "@keyword",
  ["@variable"] = {
    fg = colors.fg,
  },
  ["@variable.builtin"] = {
    fg = colors.red,
  },
  ["@variable.member"] = {
    fg = colors.green1,
  },
  ["@variable.parameter"] = {
    fg = colors.yellow,
  },
  ["@variable.parameter.builtin"] = {
    fg = "#dab484",
  },


  LspInlayHint = {
    bg = colors.none,
    fg = colors.dark3
  },
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
