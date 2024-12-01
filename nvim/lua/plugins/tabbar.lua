local C = require("plugins.configs.dev.tabline")

local M = {}
M.icon_cache = {}
function M.format(buf)
  local icon_hi = "BufIcon" .. buf.icon_highlight
  local is_select = buf:current()
  if not M.icon_cache[icon_hi] then
    local hl = vim.api.nvim_get_hl(0, { name = buf.icon_highlight, link = false })
    vim.api.nvim_set_hl(0, icon_hi, {
      fg = hl.fg,
      sp = "#74a2ff",
      underline = true,
    })
    M.icon_cache[icon_hi] = "%#" .. icon_hi .. "# " .. buf.icon
    M.icon_cache[buf.icon_highlight] = "%#" .. buf.icon_highlight .. "# " .. buf.icon
  end
  local name = ""
  local update = " 󰅖 "
  local icon = ""
  if is_select then
    icon = M.icon_cache[icon_hi]
    name = " %#BufSel#" .. buf.name
    if buf.modified then
      update = "%#BufUpdateSel#" .. " ● "
    end
  else
    icon = M.icon_cache[buf.icon_highlight]
    name = " %#Buf#" .. buf.name
    if buf.modified then
      update = "%#BufUpdate#" .. " ● "
    end
  end

  return icon .. name .. update .. "%*"
end

function Tabline()
  local bufs = C.tabline()

  local line = ""
  for i, buf in pairs(bufs) do
    line = line .. M.format(buf)
    if #bufs ~= i and #bufs > 1 then
      line = line .. "│"
    end
  end
  return line .. "%="
end

return {
  "tabline",
  dev = true,
  -- lazy = false,
  enabled = true,
  event = { "VimEnter" },
  dependencies = { "mini.icons" },
  keys = {
    { "[b", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>bnext<cr>", desc = "Next Buffer" },
    { "<leader>bd", HVIM.ui.bufremove, desc = "Delete Buffer" },
  },
  config = function()
    vim.api.nvim_set_hl(0, "TabLineSel", { underline = true, bold = true, italic = true })
    vim.api.nvim_set_hl(0, "TabLine", { underline = false, bold = false, italic = false })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })

    vim.api.nvim_set_hl(0, "BufSel", { fg = "#ffffff", sp = "#74a2ff", underline = true, bold = true, italic = true })
    vim.api.nvim_set_hl(0, "BufUpdateSel", { fg = "#fde64d", sp = "#74a2ff", underline = true })
    vim.api.nvim_set_hl(0, "BufUpdate", { fg = "#fde64d" })
    vim.api.nvim_set_hl(0, "Buf", { fg = "#a0aacc", underline = false, bold = false, italic = false })
    vim.api.nvim_set_hl(0, "BufFill", { bg = "NONE" })

    vim.o.tabline = "%!v:lua.Tabline()"
  end,
}
