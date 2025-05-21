--- @class winbar.Entry
--- @field text string The main text content of the Entry.
--- @field icon string|nil The optional icon to display before text.
--- @field hl string|nil The optional highlight group name for Neovim.
--- @field length number The total length of text and icon (plus 1 for space if icon exists).
local Entry = {}
Entry.__index = Entry

--- Creates a new Entry instance.
--- @param text string The text content for the Entry.
--- @param icon string|nil The optional icon (can be nil or empty string).
--- @param hl string|nil The optional highlight group name (can be nil or empty string).
--- @return winbar.Entry
function Entry.new(text, icon, hl)
  if type(text) ~= "string" or text == "" then
    error("text must be a non-empty string")
  end
  if icon ~= nil and (type(icon) ~= "string" or icon == "") then
    error("icon must be a non-empty string if provided")
  end
  if hl ~= nil and (type(hl) ~= "string" or hl == "") then
    error("hl must be a non-empty string if provided")
  end

  local self = setmetatable({
    text = text,
    icon = icon,
    hl = hl,
    length = text:len() + (icon and (icon:len() + 1) or 0),
  }, Entry)
  return self
end

--- Formats the Entry as a string for Neovim display.
--- @return string The formatted string with icon, highlight, and text.
function Entry:format_text()
  local parts = {}
  if self.icon then
    if self.hl then
      table.insert(parts, "%#" .. self.hl .. "#")
      table.insert(parts, self.icon)
      table.insert(parts, "%*")
    else
      table.insert(parts, self.icon)
    end
    table.insert(parts, " ")
  end
  table.insert(parts, self.text)
  return table.concat(parts)
end

return Entry
