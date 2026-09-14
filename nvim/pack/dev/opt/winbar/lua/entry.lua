---@diagnostic disable: duplicate-set-field, duplicate-doc-field
--- @class winbar.Entry
--- @field text string The main text content of the Entry.
--- @field icon string|nil The optional icon to display before text.
--- @field hl string|nil The optional highlight group name for Neovim.
--- @field length number Display width of icon+text (not byte length).
--- @field formatted string Pre-rendered winbar string for this entry.
local Entry = {}
Entry.__index = Entry

--- Creates a new Entry instance.
--- @param text string The text content for the Entry.
--- @param icon string|nil The optional icon (can be nil or empty string).
--- @param hl string|nil The optional highlight group name (can be nil or empty string).
--- @return winbar.Entry
function Entry.new(text, icon, hl)
  if type(text) ~= 'string' or text == '' then error('text must be a non-empty string') end
  if icon ~= nil and (type(icon) ~= 'string' or icon == '') then
    error('icon must be a non-empty string if provided')
  end
  if hl ~= nil and (type(hl) ~= 'string' or hl == '') then error('hl must be a non-empty string if provided') end

  local self = setmetatable({
    text = text,
    icon = icon,
    hl = hl,
  }, Entry)

  -- Use display width, not byte length: nerd-font icons and multi-byte
  -- (e.g. Vietnamese, CJK) text occupy fewer columns than bytes.
  self.length = vim.fn.strdisplaywidth(text) + (icon and (vim.fn.strdisplaywidth(icon) + 1) or 0)
  self.formatted = self:format_text()

  return self
end

--- Formats the Entry as a string for Neovim display.
--- Called once at construction time; callers should read `entry.formatted`
--- instead of calling this repeatedly.
--- @return string The formatted string with icon, highlight, and text.
function Entry:format_text()
  if not self.icon then return self.text end

  if self.hl then return table.concat({ '%#', self.hl, '#', self.icon, '%*', ' ', self.text }) end

  return table.concat({ self.icon, ' ', self.text })
end

return Entry
