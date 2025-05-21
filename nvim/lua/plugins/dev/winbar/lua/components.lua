---@diagnostic disable: undefined-field
local Entry = require("entry")

--- @class winbar.Components
local M = {}

--- Creates an Entry for the filename.
--- @param bufname string The buffer name (full path).
--- @return Entry|nil The Entry for the filename, or nil if empty.
function M.filename_entry(bufname)
  if not bufname or bufname == "" then
    return nil
  end

  local filename = vim.fn.fnamemodify(bufname, ":t")
  if filename == "" then
    return nil
  end

  local icon, hl = M.get_icon(filename)
  return Entry.new(filename, icon, hl)
end

--- Creates Entries for each directory in the path.
--- @param bufname string The buffer name (full path).
--- @return Entry[] List of Entries for directories.
function M.dirname_entry(bufname)
  if not bufname or bufname == "" then
    return {}
  end

  local dirname = vim.fn.fnamemodify(bufname, ":~:.:h")
  if dirname == "." then
    return {}
  end

  local entries = {}
  for dir in dirname:gmatch("[^/\\]+") do
    table.insert(entries, Entry.new(dir))
  end
  return entries
end

--- @return string|nil
--- @return string|nil
function M.get_icon(filename)
  local ok, MiniIcons = pcall(require, "mini.icons")
  if ok then
    return MiniIcons.get("file", filename)
  end
  return nil, nil
end

return M
