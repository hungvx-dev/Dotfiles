local ffi = require("plugins.configs.statuscol.ffidef")
local C = ffi.C
local error = ffi.new("Error")

local statuscolumn = {}

statuscolumn.number = function()
  -- local uncolored_text = "%#LineNr#"
  -- local colored_text = "%#CursorLineNr#"
  -- return vim.v.relnum == 0 and colored_text .. vim.v.lnum or uncolored_text .. vim.v.relnum
  return vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
end

statuscolumn.myStatusColumn = function()
  return table.concat({
    statuscolumn.folds(),
    "%s",
    "%r "
    -- statuscolumn.number(),
    -- "%=",
  })
end

local fold = {
  close = "󰅂",
  close1 = "",

  open = "󰅀",
  open1 = "",
  open2 = "",
  -- open1 = "",
  -- open2 = "",

  eob = " ",
  end_fold = "╰",
  sep = "│",
  branch = "",
}

statuscolumn.folds = function()
  local wp = C.find_window_by_handle(vim.g.statusline_winid, error)
  if C.compute_foldcolumn(wp, 0) == 0 then
    return ""
  end

  local foldinfo = C.fold_info(wp, vim.v.lnum)
  local lv = foldinfo.level

  if lv == 0 then
    return fold.eob
  end

  local before_foldinfo = C.fold_info(wp, vim.v.lnum - 1)
  local before_lv = before_foldinfo.level

  if foldinfo.lines > 0 then
    if lv == 1 and (before_lv == 0 or before_lv == 1) then
      return fold.close
    end
    return fold.close1
  end

  if foldinfo.start == vim.v.lnum then
    if lv == 1 and (before_lv == 0 or before_lv == 1) then
      return fold.open1
    end
    return fold.open2
  end

  local after_foldinfo = C.fold_info(wp, vim.v.lnum + 1)
  local after_lv = after_foldinfo.level

  if lv > after_lv then
    if lv == 1 and (after_lv == 0 or after_lv == 1) then
      return fold.end_fold
    end
    return fold.branch
  end

  if after_foldinfo.start > foldinfo.start then
    if lv == after_lv then
      if lv == 1 then
        return fold.end_fold
      end
      return fold.branch
    end
  end

  return fold.sep
end

return statuscolumn
