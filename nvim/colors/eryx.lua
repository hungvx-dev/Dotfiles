local colors = {
  none = 'NONE',
  bg = 'NONE',
  fg = '#ffffff',

  black = '#000000',
  white = '#f9fafb',

  slate = '#1d293d',
  gray = '#6a7282',
  gray_1 = '#62748e',
  gray_2 = '#8990b3',

  dark = '#6677c6',
  dark_1 = '#4E5BA6',
  dark_2 = '#3E4784',

  blue = '#2962FF',
  blue_1 = '#0089fc',
  sky = '#00a6f4',
  sky_1 = '#8ec5ff', -- #bedbff
  red = '#ff0c36', -- #F44336
  red_1 = '#F44336',
  red_2 = '#fc5f66',
  cyan = '#00ffff',
  cyan_1 = '#00AAD0',
  green = '#76FF03',
  yellow = '#FFEA00',
  orange = '#FF6D00',
  orange_1 = '#F79009',
  amber = '#f59e0b',
  teal = '#00F58F',
  teal_1 = '#4FF1AF',
  purple = '#df50ff',
  purple_1 = '#DE85FF',
  purple_2 = '#bd93f9',
  pink = '#FF0F80', -- #EA0E4A
  pink_1 = '#d7005f',

  diff = {
    add = '#27341c',
    delete = '#331c1e',
    change = '#102b40',
    text = '#1c4a6e',
  },

  git = {
    add = '#00E4F5',
    change = '#fb8500',
    delete = '#ff0000',
    ignore = '#545c7e',
  },
}
local base = {
  default = {
    bg = colors.bg,
    fg = colors.fg,
  },
  cursor = {
    bg = colors.bg,
    fg = colors.cyan,
  },
  transparent = {
    bg = colors.bg,
  },
}

--------------------------------------------------
-- BASE
--------------------------------------------------
vim.api.nvim_set_hl(0, 'Normal', base.default)
vim.api.nvim_set_hl(0, 'NormalFloat', base.default)
vim.api.nvim_set_hl(0, 'NormalNC', base.default)
vim.api.nvim_set_hl(0, 'NormalSB', base.default)
vim.api.nvim_set_hl(0, 'Pmenu', base.default)
vim.api.nvim_set_hl(0, 'PmenuMatch', base.cursor)
vim.api.nvim_set_hl(0, 'PmenuMatchSel', base.cursor)
vim.api.nvim_set_hl(0, 'PmenuSbar', base.transparent)
--------------------------------------------------
-- PMENU
--------------------------------------------------
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = colors.bg, sp = colors.cyan, underline = true })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.cyan })
--------------------------------------------------
-- FLOAT
--------------------------------------------------
vim.api.nvim_set_hl(0, 'FloatShadow', base.transparent)
vim.api.nvim_set_hl(0, 'FloatShadowThrough', base.transparent)
vim.api.nvim_set_hl(0, 'FloatBorder', base.cursor)
vim.api.nvim_set_hl(0, 'FloatTitle', base.cursor)

--------------------------------------------------
-- BASIC
--------------------------------------------------
vim.api.nvim_set_hl(0, 'NonText', { fg = colors.gray_1 })
vim.api.nvim_set_hl(0, 'Conceal', { link = 'NonText' })
vim.api.nvim_set_hl(0, 'Visual', { bg = colors.dark_2 })

--------------------------------------------------
-- SEARCH
--------------------------------------------------
vim.api.nvim_set_hl(0, 'IncSearch', { fg = colors.black, bg = colors.orange })
vim.api.nvim_set_hl(0, 'Search', { fg = colors.fg, bg = colors.dark_1 })
vim.api.nvim_set_hl(0, 'CurSearch', { link = 'IncSearch' })
--------------------------------------------------
-- CURSOR
--------------------------------------------------
vim.api.nvim_set_hl(0, 'Cursor', { fg = colors.bg, bg = colors.fb })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = '#292e42' })
vim.api.nvim_set_hl(0, 'CursorIM', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.bg, sp = colors.cyan, underline = true })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bold = true, fg = colors.cyan })
--------------------------------------------------
-- LINENUM
--------------------------------------------------
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.dark })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.dark })
--------------------------------------------------
-- WINDOW
--------------------------------------------------
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.black })
vim.api.nvim_set_hl(0, 'StatusLine', base.transparent)
vim.api.nvim_set_hl(0, 'StatusLineNC', base.transparent)
vim.api.nvim_set_hl(0, 'WinBar', { bg = colors.bg, fg = colors.white })
vim.api.nvim_set_hl(0, 'WinBarNC', { link = 'WinBar' })

--------------------------------------------------
-- MISC
--------------------------------------------------
vim.api.nvim_set_hl(0, 'MatchParen', { bold = true, fg = colors.none, bg = colors.cyan_1 })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = colors.none, fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Directory', { fg = colors.blue_1 })
--------------------------------------------------
-- FOLD
--------------------------------------------------
vim.api.nvim_set_hl(0, 'FoldColumn', { fg = colors.gray_1 })
vim.api.nvim_set_hl(0, 'Folded', { bg = colors.none })
vim.api.nvim_set_hl(0, 'FoldClose', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'FoldVirtual', { fg = colors.gray_1 })
vim.api.nvim_set_hl(0, 'FoldText', { fg = colors.cyan, bg = colors.slate })

--------------------------------------------------
-- SYNTAX
--------------------------------------------------
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.gray, italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'String', { fg = colors.amber })
vim.api.nvim_set_hl(0, 'Character', { fg = colors.green })
vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'Function', { fg = colors.blue_1, italic = true })
vim.api.nvim_set_hl(0, 'Statement', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'Operator', { fg = colors.sky })
vim.api.nvim_set_hl(0, 'Keyword', { fg = colors.purple_1 })
vim.api.nvim_set_hl(0, 'KeywordSpecial', { fg = colors.pink })
vim.api.nvim_set_hl(0, 'KeywordSpecial2', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'PreProc', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Type', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.red_2 })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = colors.red_2 })
vim.api.nvim_set_hl(0, 'Title', { fg = colors.blue_1 })

--------------------------------------------------
-- TREESITTER
--------------------------------------------------
vim.api.nvim_set_hl(0, '@keyword.import', { link = 'KeywordSpecial' })
vim.api.nvim_set_hl(0, '@keyword.exception', { link = 'KeywordSpecial' })
vim.api.nvim_set_hl(0, '@keyword.coroutine', { link = 'KeywordSpecial' })
vim.api.nvim_set_hl(0, '@keyword.operator', { link = 'KeywordSpecial' })
vim.api.nvim_set_hl(0, '@keyword.return', { link = 'KeywordSpecial' })
vim.api.nvim_set_hl(0, '@keyword.type', { link = 'KeywordSpecial2' })
vim.api.nvim_set_hl(0, '@keyword.function', { link = 'KeywordSpecial2' })
--------------------------------------------------
-- TYPES
--------------------------------------------------
vim.api.nvim_set_hl(0, '@type.qualifier', { link = '@keyword' })
vim.api.nvim_set_hl(0, '@type.builtin', { link = 'Type' })
vim.api.nvim_set_hl(0, '@constructor', { link = '@lsp.type.class' })
vim.api.nvim_set_hl(0, '@property', { fg = colors.teal })
vim.api.nvim_set_hl(0, '@variable', { fg = colors.fg })
vim.api.nvim_set_hl(0, '@variable.member', { link = '@property' })
vim.api.nvim_set_hl(0, '@function.builtin', { fg = colors.blue })

vim.api.nvim_set_hl(0, '@tag.attribute', { fg = colors.teal_1 })
vim.api.nvim_set_hl(0, '@tag.tsx', { link = '@type.tsx' })
--------------------------------------------------
-- COMMENT TAGS
--------------------------------------------------
vim.api.nvim_set_hl(0, '@comment.hint', { fg = colors.teal_1 })
vim.api.nvim_set_hl(0, '@comment.info', { fg = colors.sky })
vim.api.nvim_set_hl(0, '@comment.note', { fg = colors.teal })
vim.api.nvim_set_hl(0, '@comment.hack', { fg = colors.yellow })
vim.api.nvim_set_hl(0, '@comment.todo', { fg = colors.blue_1 })
vim.api.nvim_set_hl(0, '@comment.test', { fg = colors.purple })
--------------------------------------------------
-- MARKUP
--------------------------------------------------
vim.api.nvim_set_hl(0, '@markup.link', { fg = colors.teal_1, underline = true })
vim.api.nvim_set_hl(0, '@markup.environment', { link = 'Macro' })
vim.api.nvim_set_hl(0, '@markup.environment.name', { link = 'Type' })
vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { bold = true, fg = colors.blue_1 })
vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { bold = true, fg = colors.yellow })
vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { bold = true, fg = colors.green })
vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { bold = true, fg = colors.teal_1 })
vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { bold = true, fg = colors.rose })
vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { bold = true, fg = colors.purple })
vim.api.nvim_set_hl(0, '@markup.heading.7.markdown', { bold = true, fg = colors.orange })
vim.api.nvim_set_hl(0, '@markup.heading.8.markdown', { bold = true, fg = colors.red_2 })
vim.api.nvim_set_hl(0, '@markup.raw', { link = 'String' })
vim.api.nvim_set_hl(0, '@markup.raw.markdown_inline', { bg = '#414868', fg = colors.blue_1 })
--------------------------------------------------
-- LSP
--------------------------------------------------
vim.api.nvim_set_hl(0, '@lsp.type.enumMember', { link = '@variable.member' })
vim.api.nvim_set_hl(0, '@lsp.typemod.class.defaultLibrary', { link = '@type.builtin' })
vim.api.nvim_set_hl(0, '@lsp.typemod.method.defaultLibrary', { link = '@function.builtin' })
vim.api.nvim_set_hl(0, '@lsp.typemod.function.defaultLibrary', { link = '@function.builtin' })
vim.api.nvim_set_hl(0, '@lsp.type.variable', {})
vim.api.nvim_set_hl(0, '@lsp.type.component', { link = '@type.tsx' })
--------------------------------------------------
-- LSP KIND
--------------------------------------------------
vim.api.nvim_set_hl(0, 'LspKindArray', { link = '@punctuation.bracket' })
vim.api.nvim_set_hl(0, 'LspKindBoolean', { link = '@boolean' })
vim.api.nvim_set_hl(0, 'LspKindClass', { link = '@type' })
vim.api.nvim_set_hl(0, 'LspKindColor', { link = 'Special' })
vim.api.nvim_set_hl(0, 'LspKindConstant', { link = '@constant' })
vim.api.nvim_set_hl(0, 'LspKindConstructor', { link = '@constructor' })
vim.api.nvim_set_hl(0, 'LspKindEnum', { link = '@lsp.type.enum' })
vim.api.nvim_set_hl(0, 'LspKindEnumMember', { link = '@lsp.type.enumMember' })
vim.api.nvim_set_hl(0, 'LspKindEvent', { link = 'Special' })
vim.api.nvim_set_hl(0, 'LspKindField', { link = '@variable.member' })
vim.api.nvim_set_hl(0, 'LspKindFile', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'LspKindFolder', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'LspKindFunction', { link = '@function' })
vim.api.nvim_set_hl(0, 'LspKindInterface', { link = '@lsp.type.interface' })
vim.api.nvim_set_hl(0, 'LspKindKey', { link = '@variable.member' })
vim.api.nvim_set_hl(0, 'LspKindKeyword', { link = '@lsp.type.keyword' })
vim.api.nvim_set_hl(0, 'LspKindMethod', { link = '@function.method' })
vim.api.nvim_set_hl(0, 'LspKindModule', { link = '@module' })
vim.api.nvim_set_hl(0, 'LspKindNamespace', { link = '@module' })
vim.api.nvim_set_hl(0, 'LspKindNull', { link = '@constant.builtin' })
vim.api.nvim_set_hl(0, 'LspKindNumber', { link = '@number' })
vim.api.nvim_set_hl(0, 'LspKindObject', { link = '@constant' })
vim.api.nvim_set_hl(0, 'LspKindOperator', { link = '@operator' })
vim.api.nvim_set_hl(0, 'LspKindPackage', { link = '@module' })
vim.api.nvim_set_hl(0, 'LspKindProperty', { link = '@property' })
vim.api.nvim_set_hl(0, 'LspKindReference', { link = '@markup.link' })
vim.api.nvim_set_hl(0, 'LspKindSnippet', { link = 'Conceal' })
vim.api.nvim_set_hl(0, 'LspKindString', { link = '@string' })
vim.api.nvim_set_hl(0, 'LspKindStruct', { link = '@lsp.type.struct' })
vim.api.nvim_set_hl(0, 'LspKindText', { link = '@markup' })
-- vim.api.nvim_set_hl(0, "LspKindTypeParameter", { link = "@lsp.type.typeParameter" })
vim.api.nvim_set_hl(0, 'LspKindUnit', { link = '@lsp.type.struct' })
vim.api.nvim_set_hl(0, 'LspKindValue', { link = '@string' })
vim.api.nvim_set_hl(0, 'LspKindVariable', { link = '@variable' })
vim.api.nvim_set_hl(0, 'LspInlayHint', { bg = colors.none, fg = colors.gray_1 })
vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = colors.slate })

--------------------------------------------------
-- GIT
--------------------------------------------------
vim.api.nvim_set_hl(0, '@diff.delta', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, '@diff.minus', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, '@diff.plus', { link = 'DiffAdd' })

vim.api.nvim_set_hl(0, 'DiffAdd', { bg = colors.diff.add })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = colors.diff.change })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = colors.diff.delete })
vim.api.nvim_set_hl(0, 'DiffText', { bg = colors.diff.text })

vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = colors.git.add })
vim.api.nvim_set_hl(0, 'GitSignsStagedAdd', { fg = colors.teal_1 })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = colors.git.change })
vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = colors.red_1 })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = colors.git.delete })
vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = colors.gray })

--------------------------------------------------
-- NEOTREE
--------------------------------------------------
vim.api.nvim_set_hl(0, 'NeoTreeDimText', { fg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'NeoTreeFileName', { fg = colors.fg })
vim.api.nvim_set_hl(0, 'NeoTreeGitStaged', { fg = colors.teal_1 })
vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked', { fg = colors.red_1, italic = true })
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { fg = colors.fg, bg = colors.bg })

vim.api.nvim_set_hl(0, 'NeoTreeTabActive', { fg = colors.blue_1, bg = colors.bg, bold = true })
vim.api.nvim_set_hl(0, 'NeoTreeTabInactive', { fg = colors.gray_1, bg = colors.bg })
vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorActive', { fg = colors.blue_1, bg = colors.bg })
vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorInactive', { fg = colors.black, bg = colors.bg })

vim.api.nvim_set_hl(0, 'NeoTreeCursorLine', { bg = colors.bg, sp = colors.cyan, underline = true })

--------------------------------------------------
-- MIX
--------------------------------------------------
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = colors.cyan, underline = true, bold = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = colors.green, underline = true })
--------------------------------------------------
-- RAINBOW
--------------------------------------------------
vim.api.nvim_set_hl(0, 'RainbowRed', { fg = colors.red_2 })
vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = colors.blue_1 })
vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = colors.green })
vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = colors.pink })
vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = colors.cyan })

vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { link = 'RainbowRed' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { link = 'RainbowBlue' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { link = 'RainbowCyan' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { link = 'RainbowGreen' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { link = 'RainbowOrange' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { link = 'RainbowViolet' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { link = 'RainbowYellow' })
--------------------------------------------------
-- BLINK INDENT
--------------------------------------------------
vim.api.nvim_set_hl(0, 'BlinkIndentRed', { link = 'RainbowRed' })
vim.api.nvim_set_hl(0, 'BlinkIndentYellow', { link = 'RainbowYellow' })
vim.api.nvim_set_hl(0, 'BlinkIndentBlue', { link = 'RainbowBlue' })
vim.api.nvim_set_hl(0, 'BlinkIndentOrange', { link = 'RainbowOrange' })
vim.api.nvim_set_hl(0, 'BlinkIndentGreen', { link = 'RainbowGreen' })
vim.api.nvim_set_hl(0, 'BlinkIndentViolet', { link = 'RainbowViolet' })
vim.api.nvim_set_hl(0, 'BlinkIndentCyan', { link = 'RainbowCyan' })
--------------------------------------------------
-- BLINK PAIRS
--------------------------------------------------
vim.api.nvim_set_hl(0, 'BlinkPairsRed', { link = 'RainbowRed' })
vim.api.nvim_set_hl(0, 'BlinkPairsYellow', { link = 'RainbowYellow' })
vim.api.nvim_set_hl(0, 'BlinkPairsBlue', { link = 'RainbowBlue' })
vim.api.nvim_set_hl(0, 'BlinkPairsOrange', { link = 'RainbowOrange' })
vim.api.nvim_set_hl(0, 'BlinkPairsGreen', { link = 'RainbowGreen' })
vim.api.nvim_set_hl(0, 'BlinkPairsViolet', { link = 'RainbowViolet' })
vim.api.nvim_set_hl(0, 'BlinkPairsCyan', { link = 'RainbowCyan' })

--------------------------------------------------
-- BLINK
--------------------------------------------------
vim.api.nvim_set_hl(0, 'BlinkIndentRedUnderline', { sp = colors.red, underline = true })
vim.api.nvim_set_hl(0, 'BlinkIndentYellowUnderline', { sp = colors.yellow, underline = true })
vim.api.nvim_set_hl(0, 'BlinkIndentBlueUnderline', { sp = colors.blue_1, underline = true })
vim.api.nvim_set_hl(0, 'BlinkIndentOrangeUnderline', { sp = colors.orange, underline = true })
vim.api.nvim_set_hl(0, 'BlinkIndentGreenUnderline', { sp = colors.green, underline = true })
vim.api.nvim_set_hl(0, 'BlinkIndentVioletUnderline', { sp = colors.purple, underline = true })
vim.api.nvim_set_hl(0, 'BlinkIndentCyanUnderline', { sp = colors.cyan, underline = true })
--------------------------------------------------
-- BLINK CMP
--------------------------------------------------
vim.api.nvim_set_hl(0, 'BlinkCmpLabelMatch', { bg = colors.bg, fg = colors.pink_1 })
vim.api.nvim_set_hl(0, 'BlinkCmpGhostText', { fg = '#414868' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'BlinkCmpLabelDeprecated', { bg = colors.none, fg = colors.slate, strikethrough = true })

-- kinds (link)
vim.api.nvim_set_hl(0, 'BlinkCmpKindArray', { link = 'LspKindArray' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindBoolean', { link = 'LspKindBoolean' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindClass', { link = 'LspKindClass' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindColor', { link = 'LspKindColor' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindConstant', { link = 'LspKindConstant' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindConstructor', { link = 'LspKindConstructor' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindEnum', { link = 'LspKindEnum' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindEnumMember', { link = 'LspKindEnumMember' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindEvent', { link = 'LspKindEvent' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindField', { link = 'LspKindField' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindFile', { link = 'LspKindFile' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindFolder', { link = 'LspKindFolder' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindFunction', { link = 'LspKindFunction' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindInterface', { link = 'LspKindInterface' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindKey', { link = 'LspKindKey' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindKeyword', { link = 'LspKindKeyword' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindMethod', { link = 'LspKindMethod' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindModule', { link = 'LspKindModule' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindNamespace', { link = 'LspKindNamespace' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindNull', { link = 'LspKindNull' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindNumber', { link = 'LspKindNumber' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindObject', { link = 'LspKindObject' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindOperator', { link = 'LspKindOperator' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindPackage', { link = 'LspKindPackage' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindProperty', { link = 'LspKindProperty' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindReference', { link = 'LspKindReference' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindSnippet', { link = 'LspKindSnippet' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindString', { link = 'LspKindString' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindStruct', { link = 'LspKindStruct' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindText', { link = 'LspKindText' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindTypeParameter', { link = 'LspKindTypeParameter' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindUnit', { link = 'LspKindUnit' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindValue', { link = 'LspKindValue' })
vim.api.nvim_set_hl(0, 'BlinkCmpKindVariable', { link = 'LspKindVariable' })

-- custom kinds
vim.api.nvim_set_hl(0, 'BlinkCmpKindCodeium', { bg = colors.bg, fg = colors.teal_1 })
vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot', { bg = colors.bg, fg = colors.teal_1 })
vim.api.nvim_set_hl(0, 'BlinkCmpKindSupermaven', { bg = colors.none, fg = colors.teal_1 })
vim.api.nvim_set_hl(0, 'BlinkCmpKindTabNine', { bg = colors.none, fg = colors.teal_1 })

--------------------------------------------------
-- MINI ICONS
--------------------------------------------------
vim.api.nvim_set_hl(0, 'MiniIconsAzure', { fg = colors.cyan_1 })
vim.api.nvim_set_hl(0, 'MiniIconsBlue', { fg = colors.blue_1 })
vim.api.nvim_set_hl(0, 'MiniIconsCyan', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'MiniIconsGreen', { fg = colors.green })
vim.api.nvim_set_hl(0, 'MiniIconsGrey', { fg = colors.fg })
vim.api.nvim_set_hl(0, 'MiniIconsOrange', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'MiniIconsPurple', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'MiniIconsRed', { fg = colors.red })
vim.api.nvim_set_hl(0, 'MiniIconsYellow', { fg = colors.yellow })

--------------------------------------------------
-- DIAGNOSTIC
--------------------------------------------------
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = colors.red })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = colors.teal_1 })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = colors.sky })
vim.api.nvim_set_hl(0, 'DiagnosticInformation', { link = 'DiagnosticInfo' })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = colors.orange_1 })
vim.api.nvim_set_hl(0, 'DiagnosticWarning', { link = 'DiagnosticWarn' })
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = colors.gray_2 })

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { sp = colors.red, undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = colors.teal_1, undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = colors.sky, undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = colors.orange_1, undercurl = true })

--------------------------------------------------
-- FZF
--------------------------------------------------
vim.api.nvim_set_hl(0, 'FzfLuaBorder', { bg = colors.bg, fg = colors.cyan })
vim.api.nvim_set_hl(0, 'FzfLuaPreviewTitle', { bg = colors.bg, fg = colors.orange })
vim.api.nvim_set_hl(0, 'FzfLuaTitle', { bg = colors.bg, fg = colors.orange })

--------------------------------------------------
-- STATUSLINE
--------------------------------------------------
vim.api.nvim_set_hl(0, 'StModeNormal', { bg = colors.cyan, fg = colors.black })
vim.api.nvim_set_hl(0, 'StModeInsert', { bg = colors.green, fg = colors.black })
vim.api.nvim_set_hl(0, 'StModeVisual', { bg = colors.pink, fg = colors.fg })
vim.api.nvim_set_hl(0, 'StModeReplace', { bg = colors.red, fg = colors.fg })
vim.api.nvim_set_hl(0, 'StModeCommand', { bg = colors.yellow, fg = colors.black })
vim.api.nvim_set_hl(0, 'StModeDefault', { bg = colors.blue_1, fg = colors.black })

vim.api.nvim_set_hl(0, 'StModeNormalSeparator', { fg = colors.cyan, bg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StModeInsertSeparator', { fg = colors.green, bg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StModeVisualSeparator', { fg = colors.pink, bg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StModeReplaceSeparator', { fg = colors.red, bg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StModeCommandSeparator', { fg = colors.yellow, bg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StModeTerminalSeparator', { fg = colors.teal_1, bg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StModeDefaultSeparator', { fg = colors.blue_1, bg = colors.dark_2 })

vim.api.nvim_set_hl(0, 'StGitIcon', { bg = colors.dark_2, fg = colors.orange })
vim.api.nvim_set_hl(0, 'StBranchName', { bg = colors.dark_2, fg = colors.orange })
vim.api.nvim_set_hl(0, 'StBranchNameSeparator', { fg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StSectionY', { bg = colors.dark_2, fg = colors.orange })
vim.api.nvim_set_hl(0, 'StSectionYSeparator', { fg = colors.dark_2 })
vim.api.nvim_set_hl(0, 'StSeparator', { fg = colors.cyan })

--------------------------------------------------
-- TELESCOPE
--------------------------------------------------
-- vim.api.nvim_set_hl(0, 'TelescopeBorder', { link = 'FloatBorder' })
-- vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'CursorLine' })
-- vim.api.nvim_set_hl(0, 'TelescopePreviewLine', { link = 'CursorLine' })

--------------------------------------------------
-- ILLUMINATE
--------------------------------------------------
-- vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'LspReferenceText' })
-- vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'LspReferenceRead' })
-- vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'LspReferenceWrite' })
