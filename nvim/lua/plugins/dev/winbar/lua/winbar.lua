---@diagnostic disable: duplicate-set-field
local Entry = require("entry")
local Components = require("components")

--- @class winbar.Winbar
local M = {}

--- @type table<number, { entries: winbar.Entry[], length: number }>
local entries_cache = {}
--- @type table<number, table<number, { entries_text_length: number, text: string, prev_w: number }>>
local result_cache = {}

--- @param orig table
--- @return table
local function shallowcopy(orig)
  return vim.tbl_extend("force", {}, orig)
end

-- stylua: ignore start
--- Computes the total length of entries including separators and head.
--- @param entries winbar.Entry[]
--- @return number
function M.compute_entries_text_length(entries)
  if #entries == 0 then return M.head_length or 2 end
  local total = (#entries - 1) * (M.separator_length or 3) + (M.head_length or 2)
  for _, entry in ipairs(entries) do total = total + entry.length end
  return total
end
-- stylua: ignore end

--- Truncates entries to fit within max width (iterative).
--- @param entries winbar.Entry[]
--- @param entries_text_length number
--- @param max_w number
--- @return winbar.Entry[]
--- @return number
function M.truncate_path(entries, entries_text_length, max_w)
  local copy = shallowcopy(entries)
  while entries_text_length > max_w and #copy > 0 do
    table.remove(copy, 1)
    entries_text_length = M.compute_entries_text_length(copy)
  end
  if #copy < #entries and #copy > 0 then
    table.insert(copy, 1, Entry.new(M.depth_limit_indicator or "..."))
  end
  return copy, entries_text_length
end

--- Checks if winbar should be skipped for a buffer.
--- @param bufnr number
--- @return boolean
function M.should_skip_winbar(bufnr)
  return not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" or M.ignore_filetypes[vim.bo[bufnr].filetype]
end

function M.get_winbar(entries)
  if not entries or #entries == 0 then
    return M.head or ""
  end

  local parts = {}
  for _, entry in ipairs(entries) do
    if entry then
      table.insert(parts, entry:format_text())
    end
  end
  return (M.head or "") .. table.concat(parts, M.separator or " > ")
end

--- Computes entries for a window and buffer.
--- @param winnr number
--- @param bufnr number
--- @param prev_text_length number?
--- @param prev_w number?
--- @return winbar.Entry[]|nil
--- @return number -- prev_w
--- @return number -- prev_w
function M.compute(winnr, bufnr, prev_text_length, prev_w)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return {}, 0, 0
  end

  if not entries_cache[bufnr] then
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    entries_cache[bufnr] = { entries = Components.dirname_entry(bufname), length = 0 }
    local filename = Components.filename_entry(bufname)
    if filename then
      table.insert(entries_cache[bufnr].entries, filename)
    end
    entries_cache[bufnr].length = M.compute_entries_text_length(entries_cache[bufnr].entries)
  end

  local win_w = vim.api.nvim_win_get_width(winnr)
  if win_w == 0 then
    return {}, 0, 0
  end

  local entries = entries_cache[bufnr].entries
  local entries_text_length = entries_cache[bufnr].length

  prev_w = prev_w or win_w
  prev_text_length = prev_text_length ~= nil and prev_text_length or entries_text_length

  if entries_text_length > win_w or win_w ~= prev_w then
    entries, entries_text_length = M.truncate_path(entries, entries_text_length, win_w)
    if prev_text_length ~= entries_text_length then
      return entries, win_w, entries_text_length
    end
  end

  return entries, win_w, entries_text_length
end

local function update_winbar(winnr, bufnr, prev_text_length, prev_w)
  result_cache[bufnr] = result_cache[bufnr] or {}
  local entries, win_w, entries_text_length = M.compute(winnr, bufnr, prev_text_length, prev_w)

  if not result_cache[bufnr][winnr] or result_cache[bufnr][winnr].entries_text_length ~= entries_text_length then
    local text = M.get_winbar(entries)
    result_cache[bufnr][winnr] = { entries_text_length = entries_text_length, text = text, prev_w = win_w }
    vim.wo[winnr].winbar = text
  end
end

--- @param winnr number
function M.resize_update(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  if M.should_skip_winbar(bufnr) then
    return
  end
  local cache = result_cache[bufnr] and result_cache[bufnr][winnr] or {}
  update_winbar(winnr, bufnr, cache.entries_text_length, cache.prev_w)
end

--- @param args table
function M.update(args)
  local bufnr = args.buf or vim.api.nvim_get_current_buf()
  if M.should_skip_winbar(bufnr) then
    return
  end
  local winnr = vim.api.nvim_get_current_win()
  if not (result_cache[bufnr] and result_cache[bufnr][winnr]) then
    update_winbar(winnr, bufnr)
  end
end

function M.setup(opts)
  opts = opts or {}
  M.separator = table.concat({ "%#NonText#", opts.separator or " > ", "%*" })
  M.head = table.concat({ "%#TabLineSel#", opts.head or "", "%*" })
  M.depth_limit_indicator = opts.depth_limit_indicator or "..."
  M.separator_length = opts.separator_length or 3
  M.head_length = opts.head_length or 2
  M.truncate_length = opts.truncate_length or 3
  M.ignore_filetypes = vim.tbl_map(function()
    return true
  end, opts.ignore_filetypes or {})

  vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    group = vim.api.nvim_create_augroup("wb-enter", { clear = true }),
    callback = M.update,
  })

  vim.api.nvim_create_autocmd("WinResized", {
    group = vim.api.nvim_create_augroup("wb-resize", { clear = true }),
    callback = function(args)
      if not M.should_skip_winbar(args.buf) then
        -- print("resize", args.buf)
        for _, winnr in ipairs(vim.api.nvim_list_wins()) do
          M.resize_update(winnr)
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufDelete", {
    group = vim.api.nvim_create_augroup("wb-ignore", { clear = true }),
    callback = function(args)
      entries_cache[args.buf] = nil
      result_cache[args.buf] = nil
    end,
  })
end

return M
