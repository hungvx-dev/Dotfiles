local colors = require("themes.feiyu.colors")
local M = {}

local config = {
  keywords = { italic = true },
  comments = { italic = true },
  functions = { italic = true },
}

local styles = {
  keywords = {
    KwPurple = {
      fg = colors.purple,
      italic = config.keywords.italic,
    },
    KwMagenta = {
      fg = colors.magenta,
      italic = config.keywords.italic,
    },
  },
  functions = { italic = true },
}

M.treesitter = {
  keywords = {
    Special = {
      fg = colors.red,
    },
    KwPurple = styles.keywords.KwPurple,
    KwMagenta = styles.keywords.KwMagenta,
    Keyword = "KwPurple",
    Include = "KwMagenta",
    ["@keyword.import"] = "Include",
    ["@keyword.type"] = "KwPurple",
    ["@keyword.exception"] = "KwMagenta",
    ["@keyword.coroutine"] = "KwMagenta",
    ["@keyword.operator"] = "KwMagenta",
    ["@keyword.modifier"] = "KwMagenta",
    ["@keyword.return"] = "KwMagenta",
  },

  types = {
    Type = { fg = colors.blue1 },
    ["@type.builtin"] = { fg = colors.violet, bold = true },
    ["@type.definition"] = "Typedef",
  },

  functions = {
    Function = {
      fg = colors.blue,
      italic = config.functions.italic,
    },
    -- ["@constructor"] = { fg = colors. },
    -- ["@lsp.typemod.macro.defaultLibrary"] = "@function.builtin",
    -- ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
  },

  variables = {
    ["@variable"] = { fg = colors.fg, bold = false },
    ["@property"] = { fg = colors.green1 },
    ["@variable.member"] = "@property",
    ["@variable.parameter"] = { fg = colors.yellow },
    -- ["@lsp.type.property"] = "@lsp.type.property",
    ["@lsp.type.enumMember"] = "@variable.member",
    ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
    ["@lsp.typemod.type.defaultLibrary"] = "@type.builtin",
  },

  strings = {
    String = { fg = colors.green },
  },

  constants = {
    Constant = { fg = colors.orange },
  },

  modules = {
    ["@module"] = { fg = colors.cyan },
  },

  tags = {
    ["@label"] = { fg = colors.blue },
    ["@tag.attribute"] = "@variable.member",
    ["@tag.tsx"] = "@type",
  },

  comments = {
    Comment = { fg = colors.comment, italic = config.comments.italic },
    ["@comment.hint"] = { fg = colors.hint },
    ["@comment.info"] = { fg = colors.info },
    ["@comment.note"] = { fg = colors.hint },
    ["@comment.hack"] = { fg = colors.yellow },
    ["@comment.todo"] = { fg = colors.todo },
    ["@comment.test"] = { fg = colors.purple },
  },

  operators = {
    ["@operator"] = { fg = colors.blue5 },
    ["@punctuation.delimiter"] = { fg = colors.blue5 },
  },

  markups = {
    Title = {
      fg = colors.blue,
      bold = true,
    },
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
  },
}

M.lsp = {
  LspInlayHint = {
    bg = colors.none,
    fg = colors.dark3,
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
NavicIconsModule = "LspKindModule"

return M

-- NOTE: Typescript query highlight.
--[[
{
  keyword: { break, const, debugger, extends, get, let, set, static, target, var, with, default, declare, implements, type, override, module, asserts, infer, is, using
    operator: delete, void, new, delete, in, instanceof, typeof, keyof, satisfies, as
    conditional: if, else, switch, case, default
    import: import, from, as, export
    repeat: for, of, do, while, continue
    type: class, namespace, interface, enum
    coroutine: async, await
    return: return, yield
    function: function
    exception: throw, try, catch, finally
    modifier: abstract, private, protected, public, readonly
  },
  variable: {
    builtin: this, super, arguments, module, console, window, document, self
  },
  function: {
    builtin: isNaN, parseInt, require, ...
  },
  type: {
    builtin: Object, Function, Boolean, Number, String, ...
  },
  module: { global
    builtin: Intl
  }
  constant: {
    builtin: null, undefined
  },
  punctuation: {
    delimiter: ; . , :
  },
  character: {
    special: *
  },
  operator: { && || >= <= === + - * / ...

  },
  number: { Nan, Infinity

  },
  boolean: { true, false

  }
}
]]
