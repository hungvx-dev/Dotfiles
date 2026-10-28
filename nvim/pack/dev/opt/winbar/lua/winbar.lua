---@diagnostic disable: duplicate-set-field
local Entry = require('entry')
local Components = require('components')

--- @class winbar.Winbar
local M = {}

--- @type table<number, { entries: winbar.Entry[], length: number }>
local entries_cache = {}
--- @type table<number, table<number, { entries_text_length: number, text: string, prev_w: number }>>
local result_cache = {}

--- Clears all cached entries and rendered results.
--- Call this whenever anything that `Components.dirname_entry` depends on
--- changes globally, e.g. the current working directory.
local function clear_all_caches()
  entries_cache = {}
  result_cache = {}
end

--- @param orig winbar.Entry[]
--- @return winbar.Entry[]
local function shallow_copy(orig)
  local copy = {}
  for i, v in ipairs(orig) do
    copy[i] = v
  end
  return copy
end

--- Computes the total length of entries including separators and head.
--- @param entries winbar.Entry[]
--- @return number
function M.compute_entries_text_length(entries)
  if #entries == 0 then return M.head_length end
  local total = (#entries - 1) * M.separator_length + M.head_length
  for _, entry in ipairs(entries) do
    total = total + entry.length
  end
  return total
end

--- Truncates entries from the front to fit within max width.
--- Tracks length incrementally instead of recomputing from scratch on
--- every removal (avoids O(n^2) on deep paths).
--- @param entries winbar.Entry[]
--- @param entries_text_length number
--- @param max_w number
--- @return winbar.Entry[]
--- @return number
function M.truncate_path(entries, entries_text_length, max_w)
  if entries_text_length <= max_w or #entries == 0 then return entries, entries_text_length end

  local copy = shallow_copy(entries)
  local indicator = Entry.new(M.depth_limit_indicator)

  -- Since we know we'll need to insert the indicator (we're over max_w
  -- already), reserve its width + the separator that will follow it.
  local target_w = max_w - indicator.length - M.separator_length

  while entries_text_length > target_w and #copy > 0 do
    local removed = table.remove(copy, 1)
    entries_text_length = entries_text_length - removed.length
    if #copy > 0 then entries_text_length = entries_text_length - M.separator_length end
  end

  if #copy > 0 then
    table.insert(copy, 1, indicator)
    entries_text_length = entries_text_length + indicator.length + M.separator_length
  else
    -- Window too narrow even for the last entry alongside the indicator —
    -- show just the indicator.
    copy = { indicator }
    entries_text_length = M.head_length + indicator.length
  end

  return copy, entries_text_length
end

--- @type string[]|nil
M.bufname_ignore_patterns = nil -- set qua opts nếu cần, VD: { "^%[SQL Output%]" }

--- Checks if winbar should be skipped for a buffer.
--- Validity must be checked first: vim.bo[bufnr] errors on an invalid buffer.
--- @param bufnr number
--- @return boolean
function M.should_skip_winbar(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return true end
  if M.bt_ignore[vim.bo[bufnr].buftype] or M.ft_ignore[vim.bo[bufnr].filetype] then return true end
  if M.bufname_ignore_patterns then
    local name = vim.api.nvim_buf_get_name(bufnr)
    for _, pat in ipairs(M.bufname_ignore_patterns) do
      if name:match(pat) then return true end
    end
  end
  return false
end

--- @param entries winbar.Entry[]
--- @return string
function M.get_winbar(entries)
  if not entries or #entries == 0 then return M.head or '' end

  local parts = {}
  for _, entry in ipairs(entries) do
    if entry then table.insert(parts, entry.formatted) end
  end
  return (M.head or '') .. table.concat(parts, M.separator or ' > ')
end

--- Computes entries for a window and buffer.
--- @param winnr number
--- @param bufnr number
--- @param prev_text_length number?
--- @param prev_w number?
--- @return winbar.Entry[]
--- @return number current_w
--- @return number entries_text_length
function M.compute(winnr, bufnr, prev_text_length, prev_w)
  if not vim.api.nvim_buf_is_valid(bufnr) then return {}, 0, 0 end

  if not entries_cache[bufnr] then
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local dirs = Components.dirname_entry(bufname)
    local filename = Components.filename_entry(bufname)
    if filename then table.insert(dirs, filename) end
    entries_cache[bufnr] = {
      entries = dirs,
      length = M.compute_entries_text_length(dirs),
    }
  end

  local win_w = vim.api.nvim_win_get_width(winnr)
  if win_w == 0 then return {}, 0, 0 end

  local entries = entries_cache[bufnr].entries
  local entries_text_length = entries_cache[bufnr].length

  prev_w = prev_w or win_w
  prev_text_length = prev_text_length ~= nil and prev_text_length or entries_text_length

  if entries_text_length > win_w or win_w ~= prev_w then
    local max_w = math.max(win_w - M.width_margin, 0)
    entries, entries_text_length = M.truncate_path(entries, entries_text_length, max_w)
    if prev_text_length ~= entries_text_length then return entries, win_w, entries_text_length end
  end

  return entries, win_w, entries_text_length
end

local function update_winbar(winnr, bufnr, prev_text_length, prev_w)
  result_cache[bufnr] = result_cache[bufnr] or {}
  local entries, win_w, entries_text_length = M.compute(winnr, bufnr, prev_text_length, prev_w)

  local cached = result_cache[bufnr][winnr]
  if not cached or cached.entries_text_length ~= entries_text_length then
    local text = M.get_winbar(entries)
    result_cache[bufnr][winnr] = { entries_text_length = entries_text_length, text = text, prev_w = win_w }
    vim.api.nvim_set_option_value('winbar', text, { scope = 'local', win = winnr })
  end
end

--- @param winnr number
function M.resize_update(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  if M.should_skip_winbar(bufnr) then return end
  local cache = result_cache[bufnr] and result_cache[bufnr][winnr] or {}
  update_winbar(winnr, bufnr, cache.entries_text_length, cache.prev_w)
end

--- @param args { buf: number }
function M.update(args)
  local bufnr = args.buf or vim.api.nvim_get_current_buf()
  if M.should_skip_winbar(bufnr) then return end
  local winnr = vim.api.nvim_get_current_win()
  if not (result_cache[bufnr] and result_cache[bufnr][winnr]) then update_winbar(winnr, bufnr) end
end

--- Invalidates cached entries/result for a single buffer and re-renders it.
--- @param args { buf: number }
local function invalidate_buffer(args)
  entries_cache[args.buf] = nil
  result_cache[args.buf] = nil
  M.update(args)
end

--- @param arr string[]
--- @return table<string, boolean>
local function array_to_set(arr)
  local set = {}
  for _, v in ipairs(arr or {}) do
    set[v] = true
  end
  return set
end

function M.setup(opts)
  opts = opts or {}
  M.separator = table.concat({ '%#NonText#', opts.separator or ' > ', '%*' })
  M.head = table.concat({ '%#TabLineSel#', opts.head or '', '%*' })
  M.depth_limit_indicator = opts.depth_limit_indicator or '...'
  M.separator_length = opts.separator_length or vim.fn.strdisplaywidth(opts.separator or ' > ')
  M.head_length = opts.head_length or vim.fn.strdisplaywidth(opts.head or '')
  -- Extra slack allowed past win_w before we stop truncating; keeps the
  -- winbar from flapping between truncated/untruncated on tiny resizes.
  M.width_margin = opts.width_margin or 0
  M.ft_ignore = array_to_set(opts.ft_ignore)
  M.bt_ignore = array_to_set(opts.bt_ignore)

  vim.api.nvim_create_augroup('winbar', { clear = true })

  vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
    group = 'winbar',
    callback = function(args)
      vim.schedule(function() M.update(args) end)
    end,
  })

  vim.api.nvim_create_autocmd('WinResized', {
    group = 'winbar',
    callback = function()
      for _, winnr in ipairs(vim.api.nvim_list_wins()) do
        M.resize_update(winnr)
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufDelete', {
    group = 'winbar',
    callback = function(args)
      entries_cache[args.buf] = nil
      result_cache[args.buf] = nil
    end,
  })

  -- Buffer path changed (:saveas, :file, etc.) — cached dirname/filename
  -- entries are now stale.
  vim.api.nvim_create_autocmd('BufFilePost', {
    group = 'winbar',
    callback = invalidate_buffer,
  })

  -- cwd changed — dirname_entry resolves paths relative to cwd (`:.`),
  -- so every cached entry may now be wrong.
  vim.api.nvim_create_autocmd('DirChanged', {
    group = 'winbar',
    callback = clear_all_caches,
  })
end

return M
