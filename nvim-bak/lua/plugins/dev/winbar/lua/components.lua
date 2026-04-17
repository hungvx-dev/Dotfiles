---@diagnostic disable: undefined-field, duplicate-set-field
local Entry = require("entry")

--- @class winbar.Components
local M = {}

--- Creates an Entry for the filename.
--- @param bufname string The buffer name (full path).
--- @return winbar.Entry|nil The Entry for the filename, or nil if empty.
function M.filename_entry(bufname)
  if not bufname or bufname == "" then
    return nil
  end

  local filename = vim.fn.fnamemodify(bufname, ":t")
  if filename == "" then
    return nil
  end

  local icon, hl = M.get_icon("file", filename)
  return Entry.new(filename, icon, hl)
end

--- Creates Entries for each directory in the path.
--- @param bufname string The buffer name (full path).
--- @return winbar.Entry[] List of Entries for directories.
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
    local icon, hl = M.get_icon("directory", dir)
    table.insert(entries, Entry.new(dir, icon, hl))
  end
  return entries
end


--- @param type string
--- @param name string
--- @return string|nil
--- @return string|nil
function M.get_icon(type, name)
  local ok, MiniIcons = pcall(require, "mini.icons")
  if ok then
    return MiniIcons.get(type, name)
  end
  return nil, nil
end

return M
