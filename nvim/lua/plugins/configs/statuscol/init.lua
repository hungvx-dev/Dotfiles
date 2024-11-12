local ffi = require("plugins.configs.statuscol.ffidef")
local C = ffi.C
local error = ffi.new("Error")

local statuscolumn = {}

-- statuscolumn.number = function()
--   local uncolored_text = "%#LineNr#"
--   local colored_text = "%#CursorLineNr#"
--   return vim.v.relnum == 0 and colored_text .. vim.v.lnum or uncolored_text .. vim.v.relnum
-- end

statuscolumn.myStatusColumn = function()
  return table.concat({
    statuscolumn.folds(),
    "%s",
    "%l ",
    -- statuscolumn.number(),
  })
end

statuscolumn.folds = function()
  local wp = C.find_window_by_handle(vim.g.statusline_winid, error)
  local width = C.compute_foldcolumn(wp, 0)
  if width == 0 then
    return ""
  end

  local args = {
    lnum = vim.v.lnum,
    fold = {
      eofold = "╰",
      eob = " ",
      fold = " ",
      sep = "│",
      open = "󰅀",
      close = "󰅂",
      branch = "",
    },
  }

  local fold_info = C.fold_info(wp, args.lnum)
  local level = fold_info.level

  if level == 0 then
    return args.fold.fold
  end

  local text = "%#FoldLevel_" .. level .. "#"
  local foldclosed = fold_info.lines > 0

  if foldclosed then
    return text .. args.fold.close
  end

  if fold_info.start == args.lnum then
    return text .. args.fold.open
  end

  local after_fold_info = C.fold_info(wp, args.lnum + 1)
  local after_level = after_fold_info.level
  local after_foldclosed = after_fold_info.lines > 0

  local after_first_level = after_level - width - (after_foldclosed and 1 or 0) + 1
  after_first_level = math.max(after_first_level, 1)

  local is_after_open = (after_fold_info.start == args.lnum + 1) and (after_first_level + 1 > after_fold_info.llevel)
  local should_be_sep = after_level > level

  if (level > after_level or is_after_open or after_foldclosed) and not should_be_sep then
    if after_fold_info.start == after_level then
      return text .. args.fold.eofold
    end

    return text .. args.fold.branch
  end

  return text .. args.fold.sep
end

return statuscolumn
