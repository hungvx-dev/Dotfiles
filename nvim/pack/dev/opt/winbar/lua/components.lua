---@diagnostic disable: undefined-field, duplicate-set-field
local Entry = require('entry')

--- @class winbar.Components
local M = {}

-- Resolve the icon provider once at module load time, not per-call.
-- pcall+require on a missing plugin is not cheap and won't get cheaper
-- on repeat failures, so we must not re-run it for every entry.
local has_mini_icons, MiniIcons = pcall(require, 'mini.icons')

--- Resolves an icon + highlight group for a given kind/name pair.
--- @param kind string Icon category, e.g. 'file' or 'directory'.
--- @param name string The file or directory name.
--- @return string|nil icon
--- @return string|nil hl
function M.get_icon(kind, name)
  if not has_mini_icons then return nil, nil end
  return MiniIcons.get(kind, name)
end

--- Creates an Entry for the filename.
--- @param bufname string The buffer name (full path).
--- @return winbar.Entry|nil The Entry for the filename, or nil if empty.
function M.filename_entry(bufname)
  if not bufname or bufname == '' then return nil end

  local filename = vim.fn.fnamemodify(bufname, ':t')
  if filename == '' then return nil end

  local icon, hl = M.get_icon('file', filename)
  return Entry.new(filename, icon, hl)
end

--- Creates Entries for each directory in the path.
--- Note: resolves the path relative to the current working directory
--- (`:.` modifier), so callers must invalidate any cache built from this
--- on `DirChanged`.
--- @param bufname string The buffer name (full path).
--- @return winbar.Entry[] List of Entries for directories.
function M.dirname_entry(bufname)
  if not bufname or bufname == '' then return {} end

  local dirname = vim.fn.fnamemodify(bufname, ':~:.:h')
  if dirname == '.' then return {} end

  local entries = {}
  for dir in dirname:gmatch('[^/\\]+') do
    local icon, hl = M.get_icon('directory', dir)
    table.insert(entries, Entry.new(dir, icon, hl))
  end
  return entries
end

return M
