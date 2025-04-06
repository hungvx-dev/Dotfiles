local highlights = require("themes.feiyu.highlights.init")
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
  M.set_hl(highlights.base)
  M.set_mix_hl(highlights.diagnostic)

  if plugins.mini_icon then
    M.set_hl(highlights.mini_icon)
  end

  if plugins.alpha then
    M.set_hl(highlights.alpha)
  end

  if plugins.treesitter then
    for _, tree_hl in pairs(highlights.lsp.treesitter) do
      M.set_mix_hl(tree_hl)
    end
  end

  if plugins.lsp then
    M.set_mix_hl(highlights.lsp.lsp)

    if plugins.blink_cmp then
      M.set_mix_hl(highlights.blink_cmp)
    end
  end

  if plugins.neotree then
    M.set_hl(highlights.neotree)
  end

  if plugins.fzf then
    M.set_hl(highlights.fzf)
  end

  if plugins.git then
    M.set_mix_hl(highlights.git)
  end

  if plugins.git then
    M.set_mix_hl(highlights.git)
  end

  if highlight.fold then
    M.set_hl(highlights.rainbow.fold)
  else
    M.set_hl(highlights.fold)
  end

  M.set_hl(highlights.rainbow.indent)
  if plugins.blink_nvim and highlight.indent then
    M.set_link_hl(highlights.rainbow.blink.pairs)
    M.set_link_hl(highlights.rainbow.blink.indent)
    M.set_hl(highlights.rainbow.blink.underline)
  end

  M.set_hl(highlights.mix)

  -- if opts.rainbow then
  --   -- M.set_mix_hl(highlights.git)
  -- end
end

return M
