local M = {}

M.Kind = {
  Text = 1,
  Method = 2,
  Function = 3,
  Constructor = 4,
  Field = 5,
  Variable = 6,
  Class = 7,
  Interface = 8,
  Module = 9,
  Property = 10,
  Unit = 11,
  Value = 12,
  Enum = 13,
  Keyword = 14,
  Snippet = 15,
  Color = 16,
  File = 17,
  Reference = 18,
  Folder = 19,
  EnumMember = 20,
  Constant = 21,
  Struct = 22,
  Event = 23,
  Operator = 24,
  TypeParameter = 25,
}

---@alias CMHighlightRange {hl_group: string, range: integer[], text: string}

---@class CMHighlights
---@field text string
---@field highlights CMHighlightRange[]

---@class ColorfulMenuConfig
M.config = {
  ls = {},
  fallback_highlight = '@variable',
  max_width = 60,
}

local function cache_key(completion_item, ls)
  return string.format(
    '%s!%s!%s!%s!%s%s',
    completion_item.label or '',
    completion_item.detail or '',
    completion_item.labelDetails
        and (completion_item.labelDetails.detail or '') .. (completion_item.labelDetails.description or '')
      or '',
    completion_item.kind and tostring(completion_item.kind) or '',
    ls,
    require('hl-menu.utils').max_width()
  )
end

local function _highlights(completion_item, ls)
  if completion_item == nil or ls == nil or ls == '' or vim.b.ts_highlight == false then return nil end

  --- @type CMHighlights
  local item

  local key = cache_key(completion_item, ls)
  if hl_cache[key] ~= nil then return hl_cache[key] end

  if ls == 'gopls' then
    item = require('hl-menu.languages.go').gopls(completion_item, ls)
    --
  elseif ls == 'rust-glancer' then
    item = require('hl-menu.languages.rust').rust_glancer(completion_item, ls)
    --
  elseif ls == 'lua_ls' then
    item = require('hl-menu.languages.lua').lua_ls(completion_item, ls)
    --
  elseif ls == 'clangd' then
    item = require('hl-menu.languages.cpp').clangd(completion_item, ls)
    --
  elseif ls == 'tsc' then
    item = require('hl-menu.languages.typescript').tsc(completion_item, ls)
    --
  else
    return nil
  end

  item = require('hl-menu.utils').normalize_newlines(item)
  require('hl-menu.utils').apply_post_processing(completion_item, item, ls)

  hl_cache_size = hl_cache_size + 1
  if hl_cache_size > MAX_HL_CACHE_SIZE then
    hl_cache_size = 0
    hl_cache = {}
  end
  hl_cache[key] = item

  return item
end

---@diagnostic disable-next-line: undefined-doc-name
---@param ctx blink.cmp.DrawItemContext
function M.blink_components_text(ctx)
  local highlights_info = M.blink_highlights(ctx)
  if highlights_info ~= nil then
    return highlights_info.label
  else
    ---@diagnostic disable-next-line: undefined-field
    return ctx.label
  end
end

---@diagnostic disable-next-line: undefined-doc-name
---@param ctx blink.cmp.DrawItemContext
function M.blink_components_highlight(ctx)
  local highlights = {}
  local highlights_info = M.blink_highlights(ctx)
  if highlights_info ~= nil then highlights = highlights_info.highlights end
  ---@diagnostic disable-next-line: undefined-field
  for _, idx in ipairs(ctx.label_matched_indices) do
    table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
  end
  return highlights
end

---@diagnostic disable-next-line: undefined-doc-name
---@param ctx blink.cmp.DrawItemContext
function M.blink_highlights(ctx)
  ---@diagnostic disable-next-line: undefined-field
  local client = vim.lsp.get_client_by_id(ctx.item.client_id)
  local highlights = {}
  if client and not client:is_stopped() then
    ---@diagnostic disable-next-line: undefined-field
    local highlights_info = _highlights(ctx.item, client.name)
    if highlights_info ~= nil then
      for _, info in ipairs(highlights_info.highlights or {}) do
        table.insert(highlights, {
          info.range[1],
          info.range[2],
          ---@diagnostic disable-next-line: undefined-field
          group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or info[1],
        })
      end
    else
      return nil
    end
    return { label = highlights_info.text, highlights = highlights }
  end
  return nil
end

return M
