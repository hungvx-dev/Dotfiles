local highlights = require("themes.eryx.highlights.init")

local M = {}
local hl = vim.api.nvim_set_hl

--- @param highlight table<string, table>
function M.set_hl(highlight)
  for group, properties in pairs(highlight) do
    hl(0, group, properties)
  end
end

--- @param highlight table<string, string>
function M.set_link_hl(highlight)
  for group, properties in pairs(highlight) do
    hl(0, group, { link = properties })
  end
end

--- @param highlight table<string, string|table>
function M.set_mix_hl(highlight)
  for group, properties in pairs(highlight) do
    local prop_type = type(properties)
    if prop_type == "string" then
      hl(0, group, { link = properties })
    elseif prop_type == "table" then
      hl(0, group, properties)
    else
      vim.notify("Invalid highlight property type for group: " .. group, vim.log.levels.WARN)
    end
  end
end

--- @param plugins table<string, boolean>
--- @param highlight table<string, boolean>
M.setup = function(plugins, highlight)
  M.set_mix_hl(highlights.base)

  if plugins.mini_icon then
    M.set_hl(highlights.plugins.mini_icon)
  end

  if plugins.alpha then
    M.set_hl(highlights.plugins.alpha)
  end

  M.set_hl(highlights.syntax.base)
  M.set_mix_hl(highlights.syntax.special)
  M.set_link_hl(highlights.syntax.lsp)

  M.set_mix_hl(highlights.plugins.diagnostic)
  M.set_mix_hl(highlights.plugins.blink_cmp)

  if plugins.neotree then
    M.set_hl(highlights.plugins.neotree)
  end

  if plugins.fzf then
    M.set_hl(highlights.plugins.fzf)
  end

  if plugins.telescope then
    M.set_link_hl(highlights.plugins.telescope)
  end

  if plugins.git then
    M.set_mix_hl(highlights.plugins.git)
  end

  if highlight.fold then
    M.set_mix_hl(highlights.rainbow.fold)
  else
    M.set_hl(highlights.fold)
  end

  if plugins.statusline then
    M.set_mix_hl(highlights.plugins.statusline)
  end

  -- if plugins.navic then
    -- M.set_link_hl(highlights.navic)
  -- end

  M.set_hl(highlights.rainbow.indent)
  if plugins.blink_nvim and highlight.indent then
    if plugins.blink_pairs then
      M.set_link_hl(highlights.rainbow.blink.pairs)
    else
      M.set_link_hl(highlights.rainbow.pairs)
    end
    M.set_link_hl(highlights.rainbow.blink.indent)
    M.set_hl(highlights.rainbow.blink.underline)
  end

  M.set_hl(highlights.mix)
end

return M
