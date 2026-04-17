local ts_get = vim.treesitter.get_captures_at_pos
local tbl_insert = table.insert

local function fold_virt_text(result, line, lnum, coloff)
  coloff = coloff or 0

  local current_hl = nil
  local buffer = {}

  local function flush()
    if #buffer > 0 then
      tbl_insert(result, { table.concat(buffer), current_hl })
      buffer = {}
    end
  end

  for i = 1, #line do
    local col = coloff + i - 1
    local captures = ts_get(0, lnum, col)
    local last = captures[#captures]

    local new_hl = last and ('@' .. last.capture) or nil

    if new_hl ~= current_hl then
      flush()
      current_hl = new_hl
    end

    buffer[#buffer + 1] = line:sub(i, i)
  end

  flush()
end

function Custom_foldtext()
  local fs = vim.v.foldstart
  local fe = vim.v.foldend

  local tab = string.rep(' ', vim.o.tabstop)

  local start = vim.fn.getline(fs):gsub('\t', tab)
  local end_str = vim.fn.getline(fe)

  local indent = #(end_str:match('^(%s+)') or '')
  local end_ = vim.trim(end_str) .. ' '

  local result = {}

  fold_virt_text(result, start, fs - 1)

  tbl_insert(result, { HVIM.icons.UI.Ellipsis, 'TabLineSel' })

  fold_virt_text(result, end_, fe - 1, indent)

  local lines = fe - fs + 1
  tbl_insert(result, {
    string.format('%s(%d lines)', HVIM.icons.UI.FoldText, lines),
    'FoldText',
  })

  return result
end
