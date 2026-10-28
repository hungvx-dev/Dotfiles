local Kind = require('hl-menu').Kind
local config = require('hl-menu').config
local utils = require('hl-menu.utils')

local M = {}

local kind_to_hl

local function build_kind_to_hl()
  return {
    [Kind.Class] = '@type',
    [Kind.Constructor] = '@type',
    [Kind.Constant] = '@constant',
    [Kind.Function] = '@function',
    [Kind.Method] = '@function',
    [Kind.Property] = '@property',
    [Kind.Field] = '@property',
    [Kind.Variable] = '@variable',
    [Kind.Keyword] = '@keyword',
    [Kind.Enum] = utils.hl_exist_or('@lsp.type.enum', '@type'),
    [Kind.EnumMember] = utils.hl_exist_or('@lsp.type.enumMember', '@type'),
    [Kind.Interface] = utils.hl_exist_or('@lsp.type.interface', '@type'),
  }
end

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('hl-menu-kind', { clear = true }),
  callback = function() kind_to_hl = nil end,
})

---@param completion_item lsp.CompletionItem
---@param ls string
---@return CMHighlights
function M.tsc(completion_item, ls)
  local label = completion_item.label
  local kind = completion_item.kind
  if not kind then return utils.highlight_range(label, ls, 0, #label) end

  kind_to_hl = kind_to_hl or build_kind_to_hl()
  local hl = kind_to_hl[kind] or config.fallback_highlight

  return {
    text = label,
    highlights = { { hl, range = { 0, #label } } },
  }
end

return M
