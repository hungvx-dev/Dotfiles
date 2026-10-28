local config = require('hl-menu').config
local Kind = require('hl-menu').Kind

local M = {}

local exists_cache = {}

---@param name string
---@return boolean
local function hl_exists(name)
  local v = exists_cache[name]
  if v == nil then
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
    v = ok and next(hl) ~= nil
    exists_cache[name] = v
  end
  return v
end

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function() exists_cache = {} end,
})

function M.hl_exist_or(hl_group, fallback, lang)
  if lang ~= nil then
    local lang_hl = hl_group .. '.' .. lang
    if hl_exists(lang_hl) then return lang_hl end
  end
  if hl_exists(hl_group) then return hl_group end
  return fallback
end

local lang_cache = {}
local query_cache = {}
local result_cache = {}
local result_count = 0
local MAX_RESULTS = 500

local function get_lang(ft)
  local lang = lang_cache[ft]
  if lang == nil then
    lang = vim.treesitter.language.get_lang(ft) or false
    lang_cache[ft] = lang
  end
  return lang
end

local function get_query(lang)
  local entry = query_cache[lang]
  if entry == nil then
    local ok, query = pcall(vim.treesitter.query.get, lang, 'highlights')
    if ok and query then
      local names = {}
      for id, cap in ipairs(query.captures) do
        names[id] = '@' .. cap .. '.' .. lang
      end
      entry = { query = query, names = names }
    else
      entry = false
    end
    query_cache[lang] = entry
  end
  return entry
end

---@param str string
---@param _ls string
local function compute_highlights(str, _ls)
  local lang = get_lang(vim.bo.filetype)
  if not lang then return {} end

  local entry = get_query(lang)
  if not entry then return {} end

  local by_str = result_cache[lang]
  if not by_str then
    by_str = {}
    result_cache[lang] = by_str
  end
  local cached = by_str[str]
  if cached then return cached end

  local highlights, n = {}, 0
  local ok, parser = pcall(vim.treesitter.get_string_parser, str, lang)
  if ok then
    ---@diagnostic disable-next-line: need-check-nil
    local tree = parser:parse(true)[1]
    local names = entry.names
    for id, node in entry.query:iter_captures(tree:root(), str, 0, -1) do
      local _, _, sbyte, _, _, ebyte = node:range(true)
      n = n + 1
      highlights[n] = { hl_group = names[id], range = { sbyte, ebyte } }
    end
  end

  if result_count >= MAX_RESULTS then
    result_cache, result_count = {}, 0
    by_str = {}
    result_cache[lang] = by_str
  end
  by_str[str] = highlights
  result_count = result_count + 1

  return highlights
end

---@param text string
---@param ls string
---@param left integer
---@param right integer
---@return CMHighlights
function M.highlight_range(text, ls, left, right)
  local highlights = {}
  local full_hl = compute_highlights(text, ls)

  for _, hl in ipairs(full_hl) do
    local s, e = hl.range[1], hl.range[2]
    if e < left then goto continue end
    if s > right or e > right + 1 then break end

    table.insert(highlights, {
      hl.hl_group,
      range = { hl.range[1] - left, hl.range[2] - left },
      text = text:sub(s + 1, e),
    })
    ::continue::
  end

  return {
    text = text:sub(left + 1, right),
    highlights = highlights,
  }
end

function M.max_width()
  local max_width = config.max_width
  if max_width < 1 and max_width > 0 then max_width = math.floor(max_width * vim.api.nvim_win_get_width(0)) end
  return max_width
end

function M.normalize_newlines(item)
  if string.find(item.text, '\n') ~= nil or string.find(item.text, '\r') ~= nil then
    local newline_char = '↲ '
    local normalized = item.text:gsub('\r\n?', '\n')
    item.text = table.concat(vim.split(normalized, '\n'), newline_char)
  end
  return item
end

---@param item CMHighlights
---@param max_width integer
---@param direct boolean -- without type info
local function cut_label(item, max_width, direct)
  if vim.fn.strdisplaywidth(item.text) <= max_width then return end
  local text = item.text
  --- Given
  --- self.foo(asdasd)
  --- self.foo(asdasd…
  --- self.foo(asdas…)
  if direct and left_brace_one_more_than_right_brace(vim.fn.strcharpart(text, 0, max_width)) then
    local truncated = vim.fn.strcharpart(text, 0, max_width - 2) .. '…)'
    item.text = truncated
    local truncated_width = #truncated
    remove_color_in_range(item, { left = truncated_width, right = math.huge })
    add_truncation_highlights(item.highlights, truncated_width - (ellipsis_bytes + 1), '…)')
  else
    local truncated = vim.fn.strcharpart(text, 0, max_width - 1) .. '…'
    item.text = truncated
    local truncated_width = #truncated
    remove_color_in_range(item, { left = truncated_width, right = math.huge })
    table.insert(item.highlights, {
      '@comment',
      range = { truncated_width - 3, truncated_width },
    })
  end
end

---@param item CMHighlights
---@param offset integer
---@param start integer
local function shift_color_by(item, offset, start)
  for _, highlight in ipairs(item.highlights) do
    if highlight.range[1] > start then
      highlight.range[1] = highlight.range[1] - offset
      highlight.range[2] = highlight.range[2] - offset
    end
  end
end

---@param item CMHighlights
---@param ls string
---@return CMHighlights?
function M.apply_post_processing(completion_item, item, ls)
  -- if the user override or fallback logic didn't produce a table, bail
  if type(item) ~= 'table' or not item.text then return item end

  for i = #item.highlights, 1, -1 do
    local hl = item.highlights[i]
    local range = hl.range
    if range[2] < 0 then
      table.remove(item.highlights, i)
    elseif range[1] < 0 then
      range[1] = 0
    end
  end

  local max_width = require('hl-menu.utils').max_width()
  if not (max_width and max_width > 0) then return end

  local label = completion_item.label
  local display_width = vim.fn.strdisplaywidth(item.text)
  if display_width > (item.text:find('\7') ~= nil and (max_width + 1) or max_width) then
    local long_label, type = item.text:match('(.*)\7%s*(.*)')
    local is_func = completion_item.kind == Kind.Function or completion_item.kind == Kind.Method
    if
      item.text == label
      or type == nil
      or #type == 0
      or not is_func
      or not config.ls[ls]
      or not config.ls[ls].preserve_type_when_truncate
    then
      item.text = item.text:gsub('\7', ' ')
      cut_label(item, max_width, is_func)
      return
    end

    local _, le = item.text:find('\7')
    local ts = item.text:find(type, le, true)
    local space_between = ts - le
    item.text = item.text:gsub('\7', ' ')

    -- Now we need to deal with color shifting stuff.
    -- Foo(a string b string) "some random stuff"
    -- |                    | |                 |
    --   long_label_width           type_width
    --
    -- | short |  |  type_width     |
    -- Foo(a st…  "some random stuff"
    -- |         max_width          |
    local long_label_width, type_width = #long_label, #type
    local short_label_width = math.max(max_width - type_width - 2 - space_between, #label)
    local should_cut_all = short_label_width == #label
    local removed_suffix = long_label:sub(short_label_width + 1)
    if should_cut_all then
      remove_color_in_range(item, { left = short_label_width, right = long_label_width })
      local truncated_label = removed_suffix:match('%S') ~= nil
      local pretty_end = ''
      if truncated_label then
        pretty_end = '(…)'
        if label:sub(short_label_width, short_label_width) == ')' then pretty_end = '…)' end
      end
      shift_color_by(item, long_label_width - short_label_width - string.len(pretty_end), long_label_width)
      item.text = item.text:sub(1, short_label_width) .. pretty_end .. item.text:sub(long_label_width + 1)
      if truncated_label then add_truncation_highlights(item.highlights, short_label_width, pretty_end) end
      cut_label(item, max_width, false)
    else
      -- Caculate display_width and real byte diff.
      local diff = short_label_width - vim.fn.strdisplaywidth(item.text:sub(1, short_label_width))
      -- We increase the cut threshold if display_width is lower than
      -- byte count, otherwise the hole is not enough.
      short_label_width = short_label_width + diff
      local ascii_pos = short_label_width
      for i = short_label_width, 1, -1 do
        if item.text:sub(i, i):match('[a-zA-Z(]') ~= nil then
          ascii_pos = i
          break
        end
      end
      remove_color_in_range(item, { left = ascii_pos, right = long_label_width })
      shift_color_by(item, long_label_width - short_label_width - string.len('…)'), long_label_width)
      item.text = item.text:sub(1, ascii_pos)
        .. '…)'
        .. string.rep(' ', short_label_width - ascii_pos)
        .. item.text:sub(long_label_width + 1)
      add_truncation_highlights(item.highlights, ascii_pos, '…)')
    end
  else
    item.text = item.text:gsub('\7', ' ')
  end
end

return M
