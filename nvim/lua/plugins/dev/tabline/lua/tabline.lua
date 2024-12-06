local fn = vim.fn
local api = vim.api

local Utils = {}
--- @param buf table
function Utils.is_valid(buf)
  if not buf.bufnr or buf.bufnr < 1 then
    return false
  end
  local valid = api.nvim_buf_is_valid(buf.bufnr)
  if not valid then
    return false
  end
  return buf.listed == 1
end

---@return integer[]
function Utils.get_valid_buffers()
  local bufs = fn.getbufinfo()
  local valid_bufs = {}
  for _, buf in ipairs(bufs) do
    if Utils.is_valid(buf) then
      table.insert(valid_bufs, buf.bufnr)
    end
  end
  return valid_bufs
end

function Utils.get_icon(name, is_directory)
  return require("mini.icons").get(is_directory and "directory" or "file", name)
end

function Utils.tbl_add_reverse_lookup(tbl)
  local ret = {}
  for k, v in pairs(tbl) do
    ret[k] = v
    ret[v] = k
  end

  return ret
end

local Buffer = {}
function Buffer:new(buf)
  buf.modifiable = vim.bo[buf.id].modifiable
  buf.modified = vim.bo[buf.id].modified
  buf.buftype = vim.bo[buf.id].buftype
  buf.extension = fn.fnamemodify(buf.path, ":e")
  local is_directory = fn.isdirectory(buf.path) > 0
  buf.name = "[No Name]"
  if buf.path and #buf.path > 0 then
    buf.name = fn.fnamemodify(buf.path, ":t")
    buf.name = is_directory and buf.name .. "/" or buf.name
  end
  buf.icon, buf.icon_highlight = Utils.get_icon(buf.name, is_directory)

  setmetatable(buf, self)
  self.__index = self
  return buf
end

function Buffer:current()
  return api.nvim_get_current_buf() == self.id
end

local Diagnostic = {}
Diagnostic.mt = {
  __index = function(_, _)
    return { count = 0, level = nil }
  end,
}
Diagnostic.last_diagnostics_result = {}

local severity_name = Utils.tbl_add_reverse_lookup({
  [1] = "error",
  [2] = "warning",
  [3] = "info",
  [4] = "hint",
  [5] = "other",
})

setmetatable(severity_name, {
  __index = function()
    return "other"
  end,
})

function Diagnostic.is_insert()
  local mode = vim.api.nvim_get_mode().mode
  return mode == "i" or mode == "ic" or mode == "ix" or mode == "R" or mode == "Rc" or mode == "Rx"
end

function Diagnostic.diagnostics()
  local results = {}
  local diagnostics = vim.diagnostic.get()
  for _, d in pairs(diagnostics) do
    if vim.diagnostic.is_enabled({ ns_id = d.namespace, bufnr = d.bufnr }) then
      if not results[d.bufnr] then
        results[d.bufnr] = {}
      end
      table.insert(results[d.bufnr], d)
    end
  end
  return results
end

function Diagnostic.get_err_dict(errs)
  local ds = {}
  local max = #severity_name
  for _, err in ipairs(errs) do
    if err then
      -- calculate max severity
      local sev_num = err.severity
      local sev_level = severity_name[sev_num]
      if sev_num < max then
        max = sev_num
      end
      -- increment diagnostics dict
      if ds[sev_level] then
        ds[sev_level] = ds[sev_level] + 1
      else
        ds[sev_level] = 1
      end
    end
  end
  local max_severity = severity_name[max]
  return { level = max_severity, errors = ds }
end

function Diagnostic.get()
  if Diagnostic.is_insert() and not vim.diagnostic.config().update_in_insert then
    return setmetatable(Diagnostic.last_diagnostics_result, Diagnostic.mt)
  end
  local diagnostics = Diagnostic.diagnostics()
  local result = {}
  for buf_num, items in pairs(diagnostics) do
    local d = Diagnostic.get_err_dict(items)
    result[buf_num] = {
      count = #items,
      level = d.level,
      errors = d.errors,
    }
  end
  Diagnostic.last_diagnostics_result = result
  return setmetatable(result, Diagnostic.mt)
end

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

function M.tabline()
  local buf_nums = Utils.get_valid_buffers()
  local length = #buf_nums
  local line = ""

  local all_diagnostics = Diagnostic.get()
  for i, buf_id in ipairs(buf_nums) do
    local buf = Buffer:new({
      path = api.nvim_buf_get_name(buf_id),
      id = buf_id,
      ordinal = i,
      diagnostics = all_diagnostics[buf_id],
    })

    line = line .. M.format(buf)
    if length ~= i and length > 1 then
      line = line .. "│"
    end
  end
  return line .. "%="
end

function M.setup(_)
  vim.api.nvim_set_hl(0, "TabLineSel", { underline = true, bold = true, italic = true })
  vim.api.nvim_set_hl(0, "TabLine", { underline = false, bold = false, italic = false })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })

  vim.api.nvim_set_hl(0, "BufSel", { fg = "#ffffff", sp = "#74a2ff", underline = true, bold = true, italic = true })
  vim.api.nvim_set_hl(0, "BufUpdateSel", { fg = "#fde64d", sp = "#74a2ff", underline = true })
  vim.api.nvim_set_hl(0, "BufUpdate", { fg = "#fde64d" })
  vim.api.nvim_set_hl(0, "Buf", { fg = "#a0aacc", underline = false, bold = false, italic = false })
  vim.api.nvim_set_hl(0, "BufFill", { bg = "NONE" })

  vim.o.tabline = "%!v:lua.require('tabline').tabline()"
end

return M
